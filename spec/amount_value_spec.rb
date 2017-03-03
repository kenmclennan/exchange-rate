require "spec_helper"

RSpec.describe ExchangeRate::AmountValue do
  let(:val) { ExchangeRate::AmountValue.new '1.2356' }

  describe '#to_s' do
    it 'returns a string' do
      expect(val.to_s).to eq('1.2356')
    end

    it 'rounds a value' do
      expect(val.to_s(round: 2)).to eq('1.24')
    end
  end

  describe '#to_d' do
    it 'converts string values to decimal' do
      val = ExchangeRate::AmountValue.new('1.2356')
      expect(val.to_d).to eq(BigDecimal.new('1.2356'))
    end

    it 'converts integer values to decimal' do
      val = ExchangeRate::AmountValue.new(100)
      expect(val.to_d).to eq(BigDecimal.new(100))
    end

    it 'returns wrapped big decimal values' do
      decimal = BigDecimal.new('800.0009')
      val = ExchangeRate::AmountValue.new(decimal)
      expect(val.to_d).to be(decimal)
    end

    it 'converts AmountValues to decimal' do
      inner = ExchangeRate::AmountValue.new('1.2356')
      outer = ExchangeRate::AmountValue.new(inner)
      expect(val.to_d).to eq(BigDecimal.new('1.2356'))
    end
  end

end