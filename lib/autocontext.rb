require "autocontext/version"
require "autocontext/railtie" if defined?(Rails)

module Autocontext
  class Error < StandardError; end

  class Generator
    def self.generate
      # Check if Rails is defined
      raise "Rails is not defined. Please ensure you are running this within a Rails application." unless defined?(Rails)

      puts "Generating autocontext file"

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
