require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    # == Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    config.mock_with :rspec
    config.include Webrat::Matchers, :type => :view

    config.use_transactional_fixtures = true
    config.use_instantiated_fixtures  = false
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.global_fixtures = :all
    config.render_views

    config.before do
      ActionMailer::Base.deliveries = []
    end

    def new_people(count = 8, location = Location.new, opt_in = false)
      (1..count).map do |i|
        Person.new(:email => "#{location.name}_#{i}@example.com", :location => location, :opt_in => opt_in)
      end
    end

    def create_person(options)
      options.reverse_merge!(:location => Location.new(:name => "test", :address => "149 9th Street San Francisco, CA"))
      Person.create!(options)
    end
  end

end

Spork.each_run do
  # This code will be run each time you run your specs.

end

