require "exchange-rate/version"

require "exchange-rate/storage/repository"
require "exchange-rate/storage/base_adapter"
require "exchange-rate/storage/pstore_adapter"
require "exchange-rate/storage/memory_adapter"

require "exchange-rate/data_source/base_adapter"
require "exchange-rate/data_source/ecb_adapter"

require "exchange-rate/exchange_rate_converter"
require "exchange-rate/currency_rate"
require "exchange-rate/currency_amount"
require "exchange-rate/amount_value"

require 'ostruct'

module ExchangeRate
  ROOT_DIR = File.expand_path(File.join(File.dirname(__FILE__),'..'))

  def self.config
    @config ||= OpenStruct.new(
      db_adapter: ExchangeRate::Storage::PStoreAdapter,
      data_source: ExchangeRate::DataSource::ECBAdapter,
      pstore_path: :pstore_path_not_set,
      ecb_uri: "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml",
    )
  end

  def self.configure
    yield config
  end

  def self.at date, from_code, to_code
    from = repository.find_currency_at(date, from_code)
    to   = repository.find_currency_at(date, to_code)
    ExchangeRateConverter.new(from, to)
  end

  def self.repository
    @repository ||= Storage::Repository.new(config.db_adapter.new(config))
  end

  def self.data_source
    @data_source ||= config.data_source.new(config)
  end
end
