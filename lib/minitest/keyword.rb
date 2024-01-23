# frozen_string_literal: true

require "minitest"
require "minitest/keyword/version"

module Minitest
  # The module containing overridden assertion methods that will be prepended
  # into the Test class
  module Keyword
    # Longer names so that the keywords make more sense
    ALIASES = {
      a: :expected,
      act: :actual,
      b: :actual,
      cls: :class,
      exp: :expected,
      meth: :method,
      msg: :message,
      obj: :object,
      op: :operator,
      o1: :receiver,
      o2: :argument,
      sym: :symbol
    }.freeze

    # Raised if someone tries to pass both the regular arguments and the
    # keyword arguments
    class OverloadedArgumentError < ArgumentError
      def initialize(method_name, argument_name)
        super(
          "Cannot specify keyword argument and pass regular argument to " \
            "#{method_name} for argument #{argument_name}"
        )
      end
    end

    # Raised if a parameter is required but none was provided as either a
    # regular argument or a keyword argument
    class MissingRequiredArgumentError < ArgumentError
      def initialize(method_name, argument_name)
        super(
          "You must specify a value for the #{argument_name} argument " \
            "for the #{method_name} assertion"
        )
      end
    end

    Assertions
      .instance_methods
      .grep(/assert|refute/)
      .each do |method_name|
        parameters = Assertions.instance_method(method_name).parameters
        next if parameters.empty? || method_name == :assert_send

        define_method(method_name) do |*args, **kwargs, &block|
          passed_args = []
          passed_kwargs = {}

          parameters.each.with_index do |(type, arg_name), index|
            if args.length > index &&
                 (kwargs.key?(arg_name) || kwargs.key?(ALIASES[arg_name]))
              raise OverloadedArgumentError.new(method_name, arg_name)
            end

            if type == :req && args.length <= index && !kwargs.key?(arg_name) &&
                 !kwargs.key?(ALIASES[arg_name])
              raise MissingRequiredArgumentError.new(method_name, arg_name)
            end

            case type
            when :rest
              passed_args +=
                if args.any?
                  args[index..-1]
                else
                  kwargs[arg_name] || kwargs[ALIASES[arg_name]]
                end
            when :key
              passed_kwargs[arg_name] = (
                kwargs[arg_name] || kwargs[ALIASES[arg_name]]
              )
            when :req, :opt
              passed_args << (
                args[index] || kwargs[arg_name] || kwargs[ALIASES[arg_name]]
              )
            else
              raise "Unknown parameter type #{type}"
            end
          end

          super(*passed_args, **passed_kwargs, &block)
        end
      end
  end

  # Hook into the Minitest::Test class and prepend the Keyword module
  class Test
    prepend Keyword
  end
end
