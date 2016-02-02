source 'https://rubygems.org'
gemspec

gem 'rake'
gem 'rspec', '~> 2.99.0'
gem 'rspec-retry', :require => false
gem 'mocha', :require => false

gem 'activerecord', '~> 4.2'
gem 'database_cleaner'
gem 'simplecov',   :require => false
gem 'coveralls',   :require => false

platforms :ruby do
  gem 'mysql2'
end

platforms :jruby do
  gem 'jruby-openssl'
  gem 'activerecord-jdbcpostgresql-adapter'
  gem 'hot_bunnies'
end

group :development do
  gem 'pry'
  gem 'colorize'
end