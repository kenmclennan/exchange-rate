require "spec_helper"

RSpec.describe ExchangeRate::CurrencyRate do
  describe 'when initilizing' do
    it 'requires a date, a currency code & a reference rate' do
      rate = ExchangeRate::CurrencyRate.new(date: '2017-02-28', code: 'EUR', rate: '1.0987')
      expect(rate.date).to eq('2017-02-28')
      expect(rate.code).to eq('EUR')
      expect(rate.rate).to be_instance_of(ExchangeRate::AmountValue)
      expect(rate.rate.to_s).to eq('1.0987')
    end
  end
end