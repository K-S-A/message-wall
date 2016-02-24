ruby '2.3.0'
source 'https://rubygems.org'

gem 'rails', '4.2.5.1'
gem 'pg', '~> 0.18.4'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '~> 2.7'
gem 'coffee-rails', '~> 4.1.1'
# See https://github.com/rails/execjs#readme
# for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
# gem 'jquery-rails'
# Build JSON APIs with ease.
# Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.0', group: :doc

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug', '~> 8.2'
  gem 'rspec-rails', '~> 3.4'
end

group :test do
  gem 'database_cleaner', '~> 1.5'
  gem 'fuubar', '~> 2.0'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  # gem 'web-console', '~> 3.1'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 1.6'
  gem 'rubocop', '~> 0.37.2', require: false

  gem 'guard', '~> 2.13'
  gem 'guard-bundler', '~> 2.1', require: false
  gem 'guard-rspec', '~> 4.6', '>= 4.6.4', require: false
  gem 'guard-rubocop', '~> 1.2', require: false
end
