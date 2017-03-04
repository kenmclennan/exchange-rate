require 'net/http'
require 'nokogiri'

module ExchangeRate::DataSource

  class ECBAdapter < BaseAdapter
    def update repository
      fetch_data.xpath("//xmlns:Cube[@time]").each do |d|
        # these are reference rates to the euro, but the euro isn't included
        # hmmm :/
        repository.create(date: d['time'], rate: '1.0', code: 'EUR')

        d.xpath(".//xmlns:Cube[@rate]").each do |r|
          repository.create(date: d['time'], rate: r['rate'], code: r['currency'])
        end
      end
    end

    private
      def fetch_data
        response = Net::HTTP.get_response(URI(@config.ecb_uri))
        Nokogiri::XML(response.body)
      end
  end
end