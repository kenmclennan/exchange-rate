require 'pstore'

module ExchangeRate::Storage
  class PStoreAdapter< BaseAdapter

    def initialize(*)
      super
      @store = PStore.new(@config.pstore_path)
      setup_index
    end

    private def setup_index
      @store.transaction do
        @store[:rates_index] ||= {}
      end
    end

    def truncate!
      @store.transaction do
        @store.delete(:rates_index)
        @store[:rates_index] = {}
      end
    end

    def create attributes
      @store.transaction do
        date = attributes.fetch(:date)
        code = attributes.fetch(:code)
        rates = @store[:rates_index][date] ||= {}
        rates[code] = attributes.fetch(:rate)
      end
      attributes
    end

    def find_currency_at date, code
      @store.transaction do
        index = @store[:rates_index]
        if index[date] && index[date][code]
          { code: code, rate: index[date][code], date: date }
        end
      end
    end

    def find_rates_at date
      @store.transaction do
        (@store[:rates_index][date] || {}).map do |code,rate|
          { date: date, code: code, rate: rate }
        end
      end
    end

    def currency_codes
      @store.transaction do
        @store[:rates_index].values.flat_map(&:keys).uniq
      end
    end

    def date_range
      @store.transaction do
        dates = @store[:rates_index].keys.sort
        [dates.first,dates.last].compact
      end
    end
  end
end