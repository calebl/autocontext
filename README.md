# Autocontext

Autocontext is a Ruby gem that automatically generates a context file containing information about your Rails application's models, controllers, and environment.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'autocontext'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install autocontext

## Usage

To generate the autocontext file, run:

```bash
rake autocontext:generate
```

This will create a `.autocontext` file in your Rails application's root directory containing:
- Ruby and Rails versions
- List of controllers
- List of models with their:
  - Table names
  - File paths
  - Associations

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yourusername/autocontext.

## License

The gem is available as open source under the terms of the MIT License.
