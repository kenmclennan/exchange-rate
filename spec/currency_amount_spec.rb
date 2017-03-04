require "spec_helper"

RSpec.describe ExchangeRate::CurrencyAmount do
  let(:currency) { double }
  let(:amount)   { ExchangeRate::CurrencyAmount.new(100, currency) }

  describe 'when initilising' do
    it 'takes a currency object & an amount value' do
      expect(amount.amount).to be_instance_of(ExchangeRate::AmountValue)
      expect(amount.amount.to_s).to eq('100.0')
      expect(amount.currency).to be(currency)
    end
  end

  describe '#to_d' do
    it 'returns the amount as a decimal' do
      expect(amount.to_d).to eq(BigDecimal.new(100))
    end
  end

  describe '#to_s' do
    it 'generates a string representation' do
      expect(currency).to receive(:code).and_return('GBP')
      expect(amount.to_s).to eq('100.0 GBP')
    end
  end

  describe '#to_h' do
    it 'generates a hash representation' do
      expect(currency).to receive(:code).and_return('GBP')
      expect(amount.to_h).to eq({ amount: '100.0', currency: 'GBP' })
    end
  end
end