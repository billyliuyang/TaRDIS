# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'simplecov'
SimpleCov.start 'rails'

ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# If the database needs migration, purge the test database and then migrate it
# This *may* be fixed in Rails 5, but it's broken in at least Rails 4.1
if ActiveRecord::Migrator.needs_migration?
  puts('Loading schema into test database...')
  ActiveRecord::Tasks::DatabaseTasks.load_schema_for ActiveRecord::Base.configurations['test']
end
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include Shoulda::Matchers::ActiveRecord
  config.include Shoulda::Matchers::ActiveModel

  config.include Capybara::DSL              # Let's us use the capybara stuf in our specs
  config.include Warden::Test::Helpers      # Let's us do login_as(user)
  config.include Rails.application.routes.url_helpers
  config.include Capybara::Select2
  config.include Devise::TestHelpers, type: :controller

  config.after(:each) do
    Warden.test_reset!
  end

  config.mock_with :rspec

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation, { pre_count: true, reset_ids: false })
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation, { pre_count: true, reset_ids: false }
  end

  config.after(:each, js: true) do
    expect(current_path).to eq current_path
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.before(:each) do
    ActionMailer::Base.deliveries.clear
  end


  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!
end

Capybara.configure do |config|
  config.match = :prefer_exact
end

require 'capybara/poltergeist'

module Capybara::Poltergeist
  # The following code is to suppress the warning messages occurred in Mavericks
  class Client
    private
    def redirect_stdout
      prev = STDOUT.dup
      prev.autoclose = false
      $stdout = @write_io
      STDOUT.reopen(@write_io)

      prev = STDERR.dup
      prev.autoclose = false
      $stderr = @write_io
      STDERR.reopen(@write_io)
      yield
    ensure
      STDOUT.reopen(prev)
      $stdout = STDOUT
      STDERR.reopen(prev)
      $stderr = STDERR
    end
  end
end

Capybara.asset_host = 'http://localhost:3000'

class WarningSuppressor
  class << self
    def write(message)
      if message =~ /no title for patternMismatch provided. Always add a title attribute/ ||
         message =~ /QFont::setPixelSize: Pixel size <= 0/ ||
         message =~ /CoreText performance note:/ ||
         message =~ /Method userSpaceScaleFactor in class NSView is deprecated on/ ||
         message =~ /loading all features without specifing might be bad for performance/ ||
         message =~ /detected use of .* try to add support/
         0
      else
         puts(message)
         1
      end
    end
  end
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, phantomjs_logger: WarningSuppressor)
end
Capybara.javascript_driver = :poltergeist
Capybara.register_server :thin do |app, port|
  require 'rack/handler/thin'
  Rack::Handler::Thin.run(app, Port: port)
end

def wait_for_ajax
  Timeout.timeout(Capybara.default_max_wait_time) do
    loop do
      break if page.evaluate_script('jQuery.active') == 0
      sleep 0.5
    end
  end
end
