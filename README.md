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

Add `require 'minitest-keyword'` to the top of your `test_helper.rb` script. In your tests you will now be able to change your assertions from:

```ruby
assert_equal 'foo', foo.inspect
```

to:

```ruby
assert_equal exp: 'foo', act: foo.inspect
```

All of the standard Minitest assertions can now be used with keyword arguments. Note that this gem is still backwards-compatible with Minitest itself, so your existing tests won't break.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kddeisz/minitest-keyword.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
