require "exchange-rate/version"
require "exchange-rate/storage/repository"
require "exchange-rate/storage/pstore_adapter"
require "exchange-rate/currency_converter"
require "exchange-rate/currency_rate"
require "exchange-rate/currency_amount"
require "exchange-rate/amount_value"

require 'ostruct'

module ExchangeRate
  ROOT_DIR = File.expand_path(File.join(File.dirname(__FILE__),'..'))

  def self.config
    @config ||= OpenStruct.new(
      db_adapter: ExchangeRate::Storage::PStoreAdapter,
      pstore_path: File.join(ROOT_DIR,'data','exchange_rates.pstore')
    )
  end

  def self.configure
    yield config
  end

  def self.at date, from_code, to_code
    from = repository.find_currency_at(date, from_code)
    to   = repository.find_currency_at(date, to_code)
    CurrencyConverter.new(from, to)
  end

  def self.repository
    @repository ||= Storage::Repository.new(config.db_adapter.new(config))
  end
end
