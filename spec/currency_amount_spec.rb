require "spec_helper"

RSpec.describe ExchangeRate::CurrencyAmount do
  describe 'when initilising' do
    it 'takes a currency object & an amount value' do
      amount = ExchangeRate::CurrencyAmount.new 100, :currency
      expect(amount.amount).to be_instance_of(ExchangeRate::AmountValue)
      expect(amount.amount.to_s).to eq('100.0')
      expect(amount.currency).to be(:currency)
    end
  end
end