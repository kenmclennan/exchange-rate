require "bigdecimal"

module ExchangeRate
  class AmountValue
    def initialize value
      @value = value
    end

    def to_s round:4
      to_d.round(round).to_s("F")
    end

    def to_d
      case @value
      when BigDecimal
        @value
      when AmountValue
        @value.to_d
      else
        BigDecimal.new(@value)
      end
    end
  end
end