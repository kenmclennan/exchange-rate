require "spec_helper"

RSpec.describe ExchangeRate::Storage::Repository do
  let(:adapter) { double }
  let(:repo) { ExchangeRate::Storage::Repository.new adapter }

  describe '#truncate!' do
    it 'truncates the data store' do
      expect(adapter).to receive(:truncate!)
      repo.truncate!
    end
  end

  describe '#create' do
    it 'invokes the adapter to store a record' do
      attrs = { date: "2016-12-01", code: "BTN", rate: "0.6000" }

      expect(adapter).to receive(:create).with(attrs).and_return(attrs)

      record = repo.create(attrs)

      expect(record.date).to eq("2016-12-01")
      expect(record.code).to eq('BTN')
      expect(record.rate.to_s).to eq('0.6000')
    end

    it 'standardises value formats' do
      dirty = { date: Date.parse('2016-12-01'), code: 'btn', rate: '0.6000' }
      clean = { date: "2016-12-01", code: "BTN", rate: "0.6000" }

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
      expect(record.rate.to_s).to eq('7.8000')
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

  describe '#find_rates_at' do
    it 'returns an array of currency rates for a given date' do
      date  = '2013-06-20'
      rates = [{ date: date, code: 'GBP', rate: '1.2326' }]

      expect(adapter).to receive(:find_rates_at).with(date).and_return(rates)

      result = repo.find_rates_at(date)
      expect(result).to be_instance_of(Array)
      expect(result[0].rate.to_s).to eq('1.2326')
      expect(result[0].code).to eq('GBP')
      expect(result[0].date).to eq(date)
    end
  end

  describe '#currency_codes' do
    it 'returns an array of unique currency codes' do
      expect(adapter).to receive(:currency_codes).and_return([])
      expect(repo.currency_codes).to eq([])
    end
  end

  describe '#date_range' do
    it 'returns a range of dates that have data' do
      expect(adapter).to receive(:date_range).and_return([])
      expect(repo.date_range).to eq([])
    end
  end

end