require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "exchange-rate"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :exchange_rates do
  desc 'pull data from data source'
  task :update do
    data_source = ExchangeRate.data_source
    repository  = ExchangeRate.repository
    data_source.update(repository)
  end

  task :truncate do
    ExchangeRate.repository.truncate!
  end
end