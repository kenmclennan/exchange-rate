require "spec_helper"

RSpec.describe ExchangeRate do

  it "has a version number" do
    expect(ExchangeRate::VERSION).not_to be nil
  end

  it 'has a configuration' do
    expect(ExchangeRate.config).not_to be nil
    expect(ExchangeRate.config.db_adapter).to be(ExchangeRate::Storage::PStoreAdapter)
    expect(ExchangeRate.config.pstore_path).not_to be nil
  end

  it 'has a repository' do
    expect(ExchangeRate.repository).to be_instance_of(ExchangeRate::Storage::Repository)
  end

  describe '#at' do
    before do
      ExchangeRate.repository.create(date: Date.today, code: 'GBP', rate: "0.84168")
      ExchangeRate.repository.create(date: Date.today, code: 'AUD', rate: "1.4391")
    end

    it "builds a converter from stored exchange rates" do
      converter = ExchangeRate.at(Date.today,'GBP','AUD')

      expect(converter).to be_instance_of(ExchangeRate::CurrencyConverter)

      expect(converter.from.code).to eq('GBP')
      expect(converter.from.rate.to_s).to eq("0.8417")

      expect(converter.to.code).to eq('AUD')
      expect(converter.to.rate.to_s).to eq("1.4391")
    end
  end

end

