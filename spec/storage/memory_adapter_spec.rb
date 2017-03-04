require "spec_helper"

RSpec.describe ExchangeRate::Storage::MemoryAdapter do
  let(:config)  { ExchangeRate.config }
  let(:adapter) { ExchangeRate::Storage::MemoryAdapter.new config }
  let(:data)    { { date: '2014-02-02', code: 'PIE', rate: '3.14' } }

  describe '#create' do
    it 'returns an attributes hash' do
      expect(adapter.create(data)).to eq(data)
    end
  end

  describe '#find_currency_at' do
    before do
      adapter.create(data)
    end

    context 'when data in store' do
      it 'returns an attributes hash' do
        expect(adapter.find_currency_at('2014-02-02', 'PIE')).to eq(data)
      end
    end

    context 'when data not in store' do
      it 'returns nil' do
        expect(adapter.find_currency_at('3000-13-13', 'PIE')).to be nil
      end
    end
  end
end