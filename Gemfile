source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.3'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise'
gem 'devise-jwt'
gem 'pg', '~> 1.3.5'
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'rails', '~> 6.1.4'

group :development, :test do
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :test do
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end
