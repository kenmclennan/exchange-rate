require "bundler/setup"
require "exchange-rate"

require "date"

ExchangeRate.configure do |config|
  config.db_adapter  = ExchangeRate::Storage::PStoreAdapter
  config.pstore_path = File.join(ExchangeRate::ROOT_DIR,'spec','data','test_exchange_rates.pstore')
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
