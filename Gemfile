# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'
gem 'ember-cli-rails'
gem 'ember-rails'
gem 'mechanize'
gem 'pg', '~> 0.18'
gem 'geocoder', '1.4.3'
gem 'puma', '~> 3.0'
gem 'sprockets', '3.6.3'
gem 'tzinfo-data'
gem 'rollbar', '2.14.0'
gem 'lograge'
gem 'remote_syslog_logger'
gem 'rspec_junit_formatter', '0.2.3'
gem 'redis', '~> 3.0'

group :queue do
  gem 'sidekiq'
  gem 'sidekiq-batch'
  gem 'sidekiq-scheduler'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'vcr'
  gem 'webmock'
  gem 'rubocop', require: false
  gem 'coveralls', require: false
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
