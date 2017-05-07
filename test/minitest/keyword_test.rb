require 'test_helper'

module Minitest
  class KeywordTest < Test # rubocop:disable Metrics/ClassLength
    def test_version
      refute_nil Keyword::VERSION
    end

    def test_overloaded_argument_error
      assert_raises OverloadedArgumentError do
        assert true, test: true
      end
    end

    def test_missing_required_argument_error
      assert_raises MissingRequiredArgumentError do
        assert
      end
    end

    def test_assert
      assert true, 'should be true'
      assert test: true, msg: 'should be true'

      refute false, 'should be false'
      refute test: false, msg: 'should be false'
    end

    def test_assert_empty
      assert_empty [], 'should be empty'
      assert_empty obj: [], msg: 'should be empty'

      refute_empty [1], 'should not be empty'
      refute_empty obj: [1], msg: 'should not be empty'
    end

    def test_assert_equal
      assert_equal 1, 1, 'should be equal'
      assert_equal exp: 1, act: 1, msg: 'should be equal'

      refute_equal 1, 0, 'should not be equal'
      refute_equal exp: 1, act: 0, msg: 'should not be equal'
    end

    def test_assert_in_delta
      assert_in_delta Math::PI, (22.0 / 7.0), 0.01, 'should be in range'
      assert_in_delta exp: Math::PI, act: (22.0 / 7.0), delta: 0.01,
                      msg: 'should be in range'

      refute_in_delta Math::PI, (22.0 / 7.0), 0.001, 'should not be in range'
      refute_in_delta exp: Math::PI, act: (22.0 / 7.0), delta: 0.001,
                      msg: 'should not be in range'
    end

    def test_assert_in_epsilon
      assert_in_epsilon 5.0025, 4.9976, 0.001, 'should be within error'
      assert_in_epsilon a: 5.0025, b: 4.9976, epsilon: 0.001,
                        msg: 'should be within error'

      refute_in_epsilon 5.0025, 4.9974, 0.001, 'should not be within error'
      refute_in_epsilon a: 5.0025, b: 4.9974, epsilon: 0.001,
                        msg: 'should not be within error'
    end

    def test_assert_includes
      assert_includes [1, 2, 3], 1, 'should include 1'
      assert_includes collection: [1, 2, 3], obj: 1, msg: 'should include 1'

      refute_includes [1, 2, 3], 0, 'should not include 0'
      refute_includes collection: [1, 2, 3], obj: 0, msg: 'should not include 0'
    end

    def test_assert_instance_of
      assert_instance_of Hash, {}, 'should be a hash'
      assert_instance_of cls: Hash, obj: {}, msg: 'should be a hash'

      refute_instance_of Hash, [], 'should not be a hash'
      refute_instance_of cls: Hash, obj: [], msg: 'should not be a hash'
    end

    def test_assert_kind_of
      assert_kind_of Hash, {}, 'should be a hash'
      assert_kind_of cls: Hash, obj: {}, msg: 'should be a hash'

      refute_kind_of Hash, [], 'should not be a hash'
      refute_kind_of cls: Hash, obj: [], msg: 'should not be a hash'
    end

    def test_assert_match
      assert_match(/bcd/, 'abcde', 'should match the pattern')
      assert_match matcher: /bcd/, obj: 'abcde', msg: 'should match the pattern'

      refute_match(/bcd/, 'cdefg', 'should not match the pattern')
      refute_match matcher: /bcd/, obj: 'cdefg',
                   msg: 'should not match the pattern'
    end

    def test_assert_nil
      assert_nil nil, 'should be nil'
      assert_nil obj: nil, msg: 'should be nil'

      refute_nil Object.new, 'should not be nil'
      refute_nil obj: Object.new, msg: 'should not be nil'
    end

    def test_assert_operator
      assert_operator 4, :<=, 5, 'should be <= 5'
      assert_operator o1: 4, op: :<=, o2: 5, msg: 'should be <= 5'

      refute_operator 4, :>, 5, 'should not be > 5'
      refute_operator o1: 4, op: :>, o2: 5, msg: 'should not be > 5'
    end

    def test_assert_output
      assert_output('stdout', 'stderr') do
        $stdout.print 'stdout'
        $stderr.print 'stderr'
      end

      assert_output(stdout: 'stdout', stderr: 'stderr') do
        $stdout.print 'stdout'
        $stderr.print 'stderr'
      end
    end

    def test_assert_predicate
      assert_predicate '', :empty?, 'should be empty'
      assert_predicate o1: '', op: :empty?, msg: 'should be empty'

      refute_predicate 'foobar', :empty?, 'should not be empty'
      refute_predicate o1: 'foobar', op: :empty?, msg: 'should not be empty'
    end

    def test_assert_raises
      assert_raises(KeyError, ZeroDivisionError) { 1 / 0 }
      assert_raises(exp: [KeyError, ZeroDivisionError]) { 1 / 0 }
    end

    def test_assert_respond_to
      assert_respond_to [], :empty?, 'should respond to empty?'
      assert_respond_to obj: [], meth: :empty?, msg: 'should respond to empty?'

      refute_respond_to Object.new, :empty?, 'should not respond to empty?'
      refute_respond_to obj: Object.new, meth: :empty?,
                        msg: 'should not respond to empty?'
    end

    def test_assert_same
      object = Object.new

      assert_same object, object, 'should be the same'
      assert_same exp: object, act: object, msg: 'should be the same'

      refute_same object, Object.new, 'should not be the same'
      refute_same exp: object, act: Object.new, msg: 'should not be the same'
    end

    def test_assert_throws
      assert_throws(:foo, 'should throw :foo') { throw :foo }
      assert_throws(sym: :foo, msg: 'should throw :foo') { throw :foo }
    end
  end
end
