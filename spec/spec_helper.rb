require 'simplecov'
require 'rspec'
require 'tellstickr'

SimpleCov.add_filter 'spec'
SimpleCov.add_filter 'config'
SimpleCov.start


RSpec.configure do |c|
  c.mock_with :rspec
  c.before(:each) do
  end
  c.around(:each) do |example|
    example.run
  end
end
