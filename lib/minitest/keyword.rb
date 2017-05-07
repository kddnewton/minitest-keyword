require 'minitest'
require 'minitest/keyword/version'

module Minitest
  module Keyword
    class OverloadedArgumentError < ArgumentError
      def initialize(method_name, argument_name)
        super "Cannot specify keyword argument and pass regular argument to " \
              "#{method_name} for argument #{argument_name}"
      end
    end

    class MissingRequiredArgumentError < ArgumentError
      def initialize(method_name, argument_name)
        super "You must specify a value for #{argument_name} for the " \
              "#{method_name} assertion"
      end
    end

    Assertions.instance_methods.grep(/assert|refute/).each do |method_name|
      parameters = Assertions.instance_method(method_name).parameters
      next unless parameters.any? { |type, name| type == :req }

      define_method(method_name) do |*args, **kwargs|
        passed_params =
          parameters.map.with_index do |(type, argument_name), index|
            if args[index] && kwargs[argument_name]
              raise OverloadedArgumentError, method_name, argument_name
            elsif !args[index] && !kwargs[argument_name] && type == :req
              raise MissingRequiredArgumentError, method_name, argument_name
            else
              args[index] || kwargs[argument_name]
            end
          end
        super(*passed_params)
      end
    end
  end

  class Test
    prepend Keyword
  end
end
