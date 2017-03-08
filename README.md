# ExchangeRate

ExchangeRate is a library for calculating foreign exchange rates. It uses PStore
to cache data for calculating the exchange rates on a given date. The local cache
can be populated from the data published by the European Central Bank.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'exchange-rate', :git => 'git://github.com/kenmclennan/exchange-rate.git'
```

And then execute:

```bash
$ bundle
```

## Configuration

```ruby
ExchangeRate.configure do |conf|
  conf.pstore_path = '/path/to/db.pstore'
end
```

To pull data into the data store from the ECB website:

```ruby
ExchangeRate.update_data_source
```

## Usage

To convert currency amounts:

```ruby
converter = ExchangeRate.at(Date.today, 'GBP', 'EUR')
result = converter.convert(100)

result.to_s round: 2
# '117.07 EUR'

result.to_d
#<BigDecimal,'0.1170713E3',18(18)>

result.amount.to_s
# '117.0713'

result.amount.to_s round: 2
# '117.07'

result.currency.code
# 'EUR'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Ken McLennan/exchange-rate. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [The Unlicense](http://unlicense.org/).

