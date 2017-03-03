require "spec_helper"

RSpec.describe ExchangeRate::Storage::Repository do
  let(:adapter) { double }
  let(:repo) { ExchangeRate::Storage::Repository.new adapter }

  describe '#create' do
    it 'invokes the adapter to store a record' do
      attrs = { date: "2016-12-01", code: "BTN", rate: "0.6" }

      expect(adapter).to receive(:create).with(attrs).and_return(attrs)

      record = repo.create(attrs)

      expect(record.date).to eq("2016-12-01")
      expect(record.code).to eq('BTN')
      expect(record.rate.to_s).to eq('0.6')
    end

    it 'standardises value formats' do
      dirty = { date: Date.parse('2016-12-01'), code: 'btn', rate: '0.6' }
      clean = { date: "2016-12-01", code: "BTN", rate: "0.6" }

      expect(adapter).to receive(:create).with(clean).and_return(clean)

      record = repo.create(dirty)
    end
  end

  describe '#find_currency_at' do
    it 'invokes the adapter to find a record' do
      date = "2016-12-01"
      code = 'GBP'

      expect(adapter).to receive(:find_currency_at).with(date,code).and_return({date: date, code: code, rate: '7.8'})
      record = repo.find_currency_at(date,code)

      expect(record.date).to eq("2016-12-01")
      expect(record.code).to eq('GBP')
      expect(record.rate.to_s).to eq('7.8')
    end

    it 'standardises value formats' do
      date = Date.parse '2016-12-01'
      code = 'gbp'

      expect(adapter).to receive(:find_currency_at).with('2016-12-01','GBP').and_return({date: '2016-12-01', code: 'GBP', rate: '7.8'})

      record = repo.find_currency_at(date,code)
    end

    it 'raises if no data is found' do
      date = "2016-12-01"
      code = 'GBP'

      expect(adapter).to receive(:find_currency_at).with(date,code)

      expect { repo.find_currency_at(date,code) }.to raise_error(ExchangeRate::Storage::RecordNotFound)
    end
  end

end