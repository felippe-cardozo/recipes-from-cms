source 'https://rubygems.org'

gem 'contentful'
gem 'hanami', '~> 1.3'
gem 'rake'
gem 'redcarpet'

group :development do
  # Code reloading
  # See: https://guides.hanamirb.org/projects/code-reloading
  gem 'hanami-webconsole'
  gem 'shotgun', platforms: :ruby
end

group :test, :development do
  gem 'dotenv', '~> 2.4'
  gem 'webmock'
end

group :test do
  gem 'capybara'
  gem 'rspec'
  gem 'pry'
end

group :production do
  # gem 'puma'
end
