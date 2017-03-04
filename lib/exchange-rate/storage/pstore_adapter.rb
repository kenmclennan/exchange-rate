require 'pstore'

module ExchangeRate::Storage
  class PStoreAdapter< BaseAdapter

    def initialize(*)
      super
      @store = PStore.new(@config.pstore_path)
    end

    def create attributes
      @store.transaction do
        rates = @store[attributes.fetch(:date)] ||= {}
        rates[attributes.fetch(:code)] = attributes.fetch(:rate)
      end
      attributes
    end

    def find_currency_at date, code
      @store.transaction do
        if @store[date] && @store[date][code]
          { code: code, rate: @store[date][code], date: date }
        end
      end
    end
  end
end