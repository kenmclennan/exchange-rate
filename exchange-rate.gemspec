# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'exchange-rate/version'

Gem::Specification.new do |spec|
  spec.name          = "exchange-rate"
  spec.version       = ExchangeRate::VERSION
  spec.authors       = ["Ken McLennan"]
  spec.email         = ["ken@56north.net"]

  spec.summary       = %q{I figure out exchange rates!}
  spec.description   = %q{ExchangeRate uses locally stored data to provide an exhange rate between two currencies on a given date.}
  spec.homepage      = "https://github.com/kenmclennan/exchange-rate"
  spec.license       = "unlicense"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency 'nokogiri'
end
