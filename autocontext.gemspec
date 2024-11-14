require_relative 'lib/autocontext/version'

Gem::Specification.new do |spec|
  spec.name          = "autocontext"
  spec.version       = Autocontext::VERSION
  spec.authors       = ["Caleb LeNoir"]
  spec.email         = ["caleb.lenoir@hey.com"]

  spec.summary       = "Automatically generate context files for Rails applications"
  spec.description   = "A Ruby gem that generates a context file containing information about your Rails application's models, controllers, and environment"
  spec.homepage      = "https://github.com/calebl/autocontext"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.files         = Dir.glob("{bin,lib}/**/*") + %w(README.md MIT-LICENSE)
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 6.0"
end
