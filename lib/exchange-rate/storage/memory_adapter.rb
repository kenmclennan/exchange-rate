module ExchangeRate::Storage
  class MemoryAdapter < BaseAdapter

    attr_reader :store

    def initialize(*)
      super
      @store = {}
    end

    def create attributes
      rates_for_date = @store[attributes.fetch(:date)] ||= {}
      rates_for_date[attributes.fetch(:code)] = attributes.fetch(:rate)
      attributes
    end

    def find_currency_at date, code
      if @store[date] && @store[date][code]
        { code: code, rate: @store[date][code], date: date }
      end
    end
  end
end