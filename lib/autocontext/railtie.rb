require 'rails'

module Autocontext
  class Railtie < Rails::Railtie
    rake_tasks do
      namespace :autocontext do
        desc "Generate the autocontext file"
        task generate: :environment do
          Autocontext::Generator.generate
        end
      end
    end
  end
end
