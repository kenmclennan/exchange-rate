require "spec_helper"

adapters = [
  ExchangeRate::Storage::PStoreAdapter,
  ExchangeRate::Storage::MemoryAdapter
]

adapters.each do |adapter_class|

  RSpec.describe adapter_class do
    let(:config)  { ExchangeRate.config }
    let(:data)    { { date: '2014-02-02', code: 'PIE', rate: '3.14' } }
    let(:adapter) { adapter_class.new config }


    describe '#create' do
      it 'returns an attributes hash' do
        expect(adapter.create(data)).to eq(data)
      end
    end

    context 'when data in store' do
      before do
        adapter.truncate!
        adapter.create(data)
      end

      describe '#find_currency_at' do
        it 'returns an attributes hash' do
          expect(adapter.find_currency_at('2014-02-02', 'PIE')).to eq(data)
        end
      end

      describe '#find_rates_at' do
        it 'returns an array of currency rates for a given date' do
          result = adapter.find_rates_at('2014-02-02')
          expect(result).to eq([data])
        end
      end

      describe '#currency_codes' do
        it 'returns an array of unique currency codes' do
          result = adapter.currency_codes
          expect(result).to eq(['PIE'])
        end
      end

      describe '#date_range' do
        before do
          adapter.create({ date: '2014-02-02', code: 'PIE', rate: '3.14' })
          adapter.create({ date: '2014-02-03', code: 'PIE', rate: '3.14' })
          adapter.create({ date: '2014-02-04', code: 'PIE', rate: '3.14' })
        end

        it 'returns an start & end date array' do
          result = adapter.date_range
          expect(result).to eq(['2014-02-02', '2014-02-04'])
        end
      end
    end

    context 'when data not in store' do
      before do
        adapter.truncate!
      end

      describe '#find_currency_at' do
        it 'returns nil' do
          expect(adapter.find_currency_at('3000-13-13', 'PIE')).to be nil
        end
      end

      describe '#find_rates_at' do
        it 'returns an array of currency rates for a given date' do
          result = adapter.find_rates_at('2014-02-02')
          expect(result).to eq([])
        end
      end

      describe '#currency_codes' do
        it 'returns an array of unique currency codes' do
          result = adapter.currency_codes
          expect(result).to eq([])
        end
      end

      describe '#date_range' do
        it 'returns a range of dates that have data' do
          result = adapter.date_range
          expect(result).to eq([])
        end
      end
    end
  end
end