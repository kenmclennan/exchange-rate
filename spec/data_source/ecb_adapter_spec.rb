require "spec_helper"

RSpec.describe ExchangeRate::DataSource::ECBAdapter do
  let(:config)     { ExchangeRate.config }
  let(:adapter)    { ExchangeRate::Storage::MemoryAdapter.new(config) }
  let(:ecb_xml)    { File.read(File.join(ExchangeRate::ROOT_DIR,'spec','data','web','ecb.xml')) }
  let(:repository) { ExchangeRate::Storage::Repository.new(adapter) }
  let(:source)     { ExchangeRate::DataSource::ECBAdapter.new(config) }

  it 'updates a repository from a remote data source' do
    stub_request(:get, config.ecb_uri).to_return(body: ecb_xml)

    expect(adapter.store).to be_empty

    source.update(repository)

    expect(adapter.store).not_to be_empty
  end
end