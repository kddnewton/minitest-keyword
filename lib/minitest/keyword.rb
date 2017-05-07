require 'minitest'
require 'minitest/keyword/version'

module Minitest
  # The module containing overridden assertion methods that will be prepended
  # into the Test class
  module Keyword
    # Raised if someone tries to pass both the regular arguments and the
    # keyword arguments
    class OverloadedArgumentError < ArgumentError
      def initialize(method_name, argument_name)
        super('Cannot specify keyword argument and pass regular argument to ' \
              "#{method_name} for argument #{argument_name}")
      end
    end

    # Raised if a parameter is required but none was provided as either a
    # regular argument or a keyword argument
    class MissingRequiredArgumentError < ArgumentError
      def initialize(method_name, argument_name)
        super("You must specify a value for the #{argument_name} argument " \
              "for the #{method_name} assertion")
      end
    end

    Assertions.instance_methods.grep(/assert|refute/).each do |method_name|
      parameters = Assertions.instance_method(method_name).parameters
      next if parameters.empty?

      define_method(method_name) do |*args, **kwargs, &block|
        passed_params =
          parameters.map.with_index do |(type, arg_name), index|
            if args.length > index && kwargs.key?(arg_name)
              raise OverloadedArgumentError.new(method_name, arg_name)
            end

            if args.length <= index && !kwargs.key?(arg_name) && type == :req
              raise MissingRequiredArgumentError.new(method_name, arg_name)
            end

            if type == :rest
              args.any? ? args[index..-1] : kwargs[arg_name]
            else
              args[index] || kwargs[arg_name]
            end
          end

        # Special case for behavior like `assert_raises`, where a splat takes
        # all of the types of errors for rescue
        if parameters.length == 1 && parameters[0][0] == :rest
          passed_params.flatten!(1)
        end

        super(*passed_params, &block)
      end
    end
  end

  # Hook into the Minitest::Test class and prepend the Keyword module
  class Test
    prepend Keyword
  end
end
