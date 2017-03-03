module ExchangeRate
  class CurrencyRate
    attr_reader :code, :date

    def initialize date:, code:, rate:
      @date = date
      @code = code
      @rate = rate
    end

    def rate
      AmountValue.new(@rate)
    end
  end
end