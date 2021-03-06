source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.0.5'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'bootstrap', '~>4.0.0.alpha6'
gem 'capybara', '~> 2.12', group: %w(test development)
gem 'capybara-webkit', group: %w(test development)
gem 'carrierwave', '~>1.0'
gem 'carrierwave-aws', '~>1.0', '>=1.0.2'
gem 'cocoon', '~>1.2', '>=1.2.9'
gem 'cucumber-rails', require: false, group: %w(test development)
gem 'database_cleaner', '~> 1.5', group: %w(test development)
gem 'devise', '~>4.2'
gem 'dotenv-rails', '~>2.1'
gem 'factory_girl_rails', '~> 4.8', group: %w(test development)
gem 'font-awesome-rails', '~> 4.7'
gem 'friendly_id', '~> 5.1.0'
gem 'gritter', '~>1.2'
gem 'i18n-tasks', '~>0.9.8'
gem 'jquery-ui-rails', '~>6.0'
gem 'launchy'
gem 'mini_magick', '~>4.6'
gem 'rails-i18n', '~> 5.0'
gem 'rails_12factor'
gem 'rspec-rails', '~> 3.5', group: %w(test development)
gem 'faker', '~> 1.7', '>= 1.7.3'
