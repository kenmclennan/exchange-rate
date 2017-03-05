require "spec_helper"

RSpec.describe ExchangeRate::ExchangeRateConverter do
  let(:pounds) { ExchangeRate::CurrencyRate.new(date: '2017-02-28', code: 'GBP', rate: '0.5') }
  let(:euros) { ExchangeRate::CurrencyRate.new(date: '2017-02-28', code: 'EUR', rate: '1.0') }
  let(:converter) { ExchangeRate::ExchangeRateConverter.new pounds, euros }

  it 'converts between two currency rates' do
    expect(converter.from).to be(pounds)
    expect(converter.to).to be(euros)
  end

  it 'converts to a currency amount' do
    amount = converter.convert(123)
    expect(amount).to be_instance_of(ExchangeRate::CurrencyAmount)
    expect(amount.currency).to be(euros)
    expect(amount.amount.to_s).to eq("246.0000")
  end

  it 'calculates the exchange rate' do
    expect(converter.exchange_rate).to be_instance_of(ExchangeRate::AmountValue)
    expect(converter.exchange_rate.to_s).to eq('2.0000')
  end
end