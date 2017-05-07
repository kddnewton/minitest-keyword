require 'minitest'
require 'minitest/keyword/version'

module Minitest
  module Keyword
    class OverloadedArgumentError < ArgumentError
      def initialize(method_name, argument_name)
        super("Cannot specify keyword argument and pass regular argument to " \
              "#{method_name} for argument #{argument_name}")
      end
    end

    class MissingRequiredArgumentError < ArgumentError
      def initialize(method_name, argument_name)
        super("You must specify a value for the #{argument_name} argument " \
              "for the #{method_name} assertion")
      end
    end

    Assertions.instance_methods.grep(/assert|refute/).each do |method_name|
      parameters = Assertions.instance_method(method_name).parameters
      next unless parameters.any? { |type, name| type == :req }

      define_method(method_name) do |*args, **kwargs|
        passed_params =
          parameters.map.with_index do |(type, arg_name), index|
            if args.length > index && kwargs.key?(arg_name)
              raise OverloadedArgumentError.new(method_name, arg_name)
            elsif args.length <= index && !kwargs.key?(arg_name) && type == :req
              raise MissingRequiredArgumentError.new(method_name, arg_name)
            else
              args[index] || kwargs[arg_name]
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
