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

    def to_s *options
      "#{amount.to_s(*options)} #{currency.code}"
    end

    def to_h *options
      {amount: amount.to_s(*options), currency: currency.code }
    end

    def to_d
      amount.to_d
    end
  end
end