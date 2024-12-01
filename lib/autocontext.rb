require "autocontext/version"
require "autocontext/railtie" if defined?(Rails)

module Autocontext
  class Error < StandardError; end

  class Generator
    def self.generate(path = ".")
      original_dir = Dir.pwd
      Dir.chdir(path)

      begin
        if File.exist?('config/application.rb')
          # Use the project's bundle environment
          require 'bundler'
          Bundler.with_unbundled_env do
            system("bundle exec ruby -r './config/application.rb' -e 'require \"autocontext\"; Autocontext::Generator.generate_rails_context'")
          end
        else
          puts "Error: No Rails application found in #{path}"
          puts "Please specify a valid Rails application path"
          exit 1
        end
      ensure
        Dir.chdir(original_dir)
      end
    end

    def self.generate_rails_context
      puts "Generating autocontext file"

      # Initialize the Rails application first
      Rails.application.initialize!
      # Then eager load
      Rails.application.eager_load!

      gemfile_content = File.read(Rails.root.join('Gemfile'))

      ruby_version = gemfile_content.match(/ruby ['"](.+?)['"]/i)&.captures&.first
      rails_version = gemfile_content.match(/gem ['"]rails['"],\s*['"](.+?)['"]/i)&.captures&.first

      File.open('.autocontext', 'w') do |file|
        file.puts "/* AutoContext generation completed at #{Time.now} */"
        file.puts "Ruby version: #{ruby_version}"
        file.puts "Rails version: #{rails_version}"
        file.puts ""
        self.generate_controllers(file)
        file.puts ""
        file.puts "Models:"
        ApplicationRecord.descendants.each do |model|
          file.puts "  #{model.name}:"
          file.puts "    superclass: #{model.superclass.name}"
          file.puts "    database: #{model.connection.current_database}"
          file.puts "    table_name: #{model.table_name}"
          file.puts "    relative path: app/models/#{model.name.underscore}.rb"

          self.generate_associations(model, file)
          file.puts ""

        rescue => e
          puts "Error generating autocontext for #{model.name}: #{e.message}"
        end
      end
    end

    def self.generate_controllers(file)
      file.puts "Controllers:"
      file.puts " - #{ApplicationController.descendants.map(&:name).join(", ")}"
    end

    def self.generate_associations(model, file)
      file.puts "    associations:"
      model.reflect_on_all_associations.each do |association|
        file.puts "    - #{association.macro} #{association.name} #{association.foreign_key} #{association.polymorphic? ? "polymorphic" : ""} (#{association.class_name})"
      rescue => e
        puts "Error generating associations for #{model.name}: #{e.message}"
      end
    end
  end
end
