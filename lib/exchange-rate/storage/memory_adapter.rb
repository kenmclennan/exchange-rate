module ExchangeRate::Storage
  class MemoryAdapter < BaseAdapter

    attr_reader :store

    def initialize(*)
      super
      @store = {}
    end

    def truncate!
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

    def find_rates_at date
      (@store[date] || {}).map do |code,rate|
        { date: date, code: code, rate: rate }
      end
    end

    def currency_codes
      @store.values.flat_map(&:keys).uniq
    end

    def date_range
      dates = @store.keys.sort
      [dates.first,dates.last].compact
    end
  end
end