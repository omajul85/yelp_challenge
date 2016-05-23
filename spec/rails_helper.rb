# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end


# rspec-rails 3 generates spec_helper.rb and rails_helper.rb. spec_helper.rb is for specs which don't depend on Rails (such as specs for classes in the lib directory). rails_helper.rb is for specs which do depend on Rails (in a Rails project, most or all of them). rails_helper.rb requires spec_helper.rb. So no, don't get rid of rails_helper.rb; require it (and not spec_helper.rb) in your specs.