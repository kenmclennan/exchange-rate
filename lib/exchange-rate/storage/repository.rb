module ExchangeRate::Storage

  class RecordNotFound < RuntimeError; end

  class Repository
    def initialize adapter
      @adapter = adapter
    end

    def create date:, code:, rate:
      build_record(@adapter.create(
        date: fdate(date),
        code: fcode(code),
        rate: rate
      ))
    end

    def find_currency_at date, code
      data = @adapter.find_currency_at(fdate(date), fcode(code))
      unless data
        raise RecordNotFound.new("Could not find exchange rate data for #{code} at #{date}")
      end
      build_record(data)
    end

    private

      def build_record attributes
        ExchangeRate::CurrencyRate.new(attributes)
      end

      def fdate date
        date = String === date ? Date.parse(date) : date
        date.strftime('%Y-%m-%d')
      end

      def fcode code
        code.upcase
      end
    end
end