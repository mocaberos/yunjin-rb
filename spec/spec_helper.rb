# frozen_string_literal: true

require 'yunjin'
require 'simplecov'
require 'json_expressions/rspec'
require 'typhoeus'

SimpleCov.minimum_coverage 90
SimpleCov.at_exit do
  SimpleCov.result.format!

  if SimpleCov.result.covered_percent < 90
    puts "\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
    puts "Converage is under 90%. See `coverage/index.html`\n"
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n"
    abort('Test failed.')
  end
end
SimpleCov.formatter = SimpleCov::Formatter::Codecov if ENV['CODECOV_TOKEN']
SimpleCov.start

RSpec.configure do |config|
  config.order = :random
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before :each do
    Typhoeus::Expectation.clear

    # @note テスト中は動作ログを出力させない
    allow(YunJin.logger).to receive(:debug).and_return(nil)
    allow(YunJin.logger).to receive(:info).and_return(nil)
    allow(YunJin.logger).to receive(:warn).and_return(nil)
    allow(YunJin.logger).to receive(:error).and_return(nil)
    allow(YunJin.logger).to receive(:fatal).and_return(nil)
  end
end
