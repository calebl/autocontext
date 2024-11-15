# Autocontext

Autocontext is a Ruby gem that automatically generates a context file containing information about your Rails application's models, controllers, and environment. This context can then be used in conversations with LLMs
to help them understand your application.

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


## Future Work
- For larger projects, generate the context around specific controllers or models instead of the entire application.
- Include view code in the context.
- Add more details to controller descriptions.

## Development

Checkout the repo and run `bundle install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yourusername/autocontext.

## License

The gem is available as open source under the terms of the MIT License.
