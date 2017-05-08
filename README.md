# Minitest::Keyword

[![Build Status](https://travis-ci.org/kddeisz/minitest-keyword.svg?branch=master)](https://travis-ci.org/kddeisz/minitest-keyword)
[![Coverage Status](https://coveralls.io/repos/github/kddeisz/minitest-keyword/badge.svg?branch=master)](https://coveralls.io/github/kddeisz/minitest-keyword?branch=master)
[![Gem](https://img.shields.io/gem/v/minitest-keyword.svg)](https://rubygems.org/gems/minitest-keyword)

A small gem for allowing you to use Minitest assertions with keyword arguments. No longer worry about remembering the order of arguments!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minitest-keyword'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install minitest-keyword

## Usage

Add `require 'minitest/keyword'` to your `test_helper.rb` script. In your tests you will now be able to change your assertions from:

```ruby
assert_equal 'foo', foo.inspect
```

to:

```ruby
assert_equal expected: 'foo', actual: foo.inspect
```

All of the standard Minitest assertions can now be used with keyword arguments. Note that this gem is still backwards-compatible with Minitest itself, so your existing tests won't break.

## Cheat Sheet

The actual keyword method creation is done through introspection, but the equivalent method signatures are listed below. Note that when you see `message: nil` it effectively means that you can pass through a message or it will use whatever standard Minitest message is configured for that assertion.

```ruby
assert             test:, message: nil
assert_empty       object:, message: nil
assert_equal       expected:, actual:, message: nil
assert_in_delta    expected:, actual:, delta:, message: nil
assert_in_epsilon  a:, b:, epsilon:, message: nil
assert_includes    collection:, object:, message: nil
assert_instance_of class:, object:, message: nil
assert_kind_of     class:, object:, message: nil
assert_match       matcher:, object:, message: nil
assert_nil         object:, message: nil
assert_operator    o1:, op:, o2:, message: nil
assert_output      stdout:, stderr:
assert_predicate   o1:, op:, message: nil
assert_raises      expected:
assert_respond_to  object:, method:, message: nil
assert_same        expected:, actual:, message: nil
assert_throws      symbol:, message: nil
```

The associated refutations are also overridden, with the below signatures.

```ruby
refute             test:, message: nil
refute_empty       object:, message: nil
refute_equal       expected:, actual:, message: nil
refute_in_delta    expected:, actual:, delta:, message: nil
refute_in_epsilon  a:, b:, epsilon:, message: nil
refute_includes    collection:, object:, message: nil
refute_instance_of class:, object:, message: nil
refute_kind_of     class:, object:, message: nil
refute_match       matcher:, object:, message: nil
refute_nil         object:, message: nil
refute_operator    o1:, op:, o2:, message: nil
refute_predicate   o1:, op:, message: nil
refute_respond_to  object:, method:, message: nil
refute_same        expected:, actual:, message: nil
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kddeisz/minitest-keyword.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
