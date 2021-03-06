require "rubygems"
require "bundler"

module Horus
  class Application

    def self.root(path = nil)
      @_root ||= File.expand_path(File.dirname(__FILE__))
      path ? File.join(@_root, path.to_s) : @_root
    end

    def self.env
      @_env ||= ENV['RACK_ENV'] || 'development'
    end

    def self.routes
      @_routes ||= eval(File.read('./config/routes.rb'))
    end

    # Initialize the application
    def self.initialize!
    end
    
    def self.find_game(id)
      Game.find(id)
    end
    
    def self.start_new_game(nick)
      Game.create(nick)
    end
  end
end

Bundler.require(:default, Horus::Application.env)

# Preload application classes
Dir[File.join(File.dirname(__FILE__), 'app/**/*.rb')].each {|f| require f}
