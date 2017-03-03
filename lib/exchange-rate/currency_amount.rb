module ExchangeRate
  class CurrencyAmount
    attr_reader :currency

    def initialize amount, currency
      @amount   = amount
      @currency = currency
    end

    def amount
      AmountValue.new(@amount)
    end
  end
end