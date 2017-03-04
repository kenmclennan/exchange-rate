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

    def to_s
      "#{amount} #{currency.code}"
    end

    def to_h
      {amount: amount.to_s, currency: currency.code }
    end

    def to_d
      amount.to_d
    end
  end
end