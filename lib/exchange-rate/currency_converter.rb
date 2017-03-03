module ExchangeRate
  class CurrencyConverter
    attr_reader :from, :to

    def initialize from, to
      @from = from
      @to   = to
    end

    def exchange_rate
      AmountValue.new(to.rate.to_d / from.rate.to_d)
    end

    def convert amount
      new_amount = exchange_rate.to_d * AmountValue.new(amount).to_d
      CurrencyAmount.new(new_amount, to)
    end
  end
end