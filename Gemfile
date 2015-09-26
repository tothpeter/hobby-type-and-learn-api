source 'https://rubygems.org'
ruby '2.2.3'

gem 'rails', '4.2.3'
gem 'rails-api'
gem 'spring', :group => :development
gem 'pg'
gem 'puma'

# To use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', :group => :development

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :production do
  gem 'airbrake'
end

group :development do
  gem 'capistrano'
  gem 'capistrano-bundler', require: false
  gem 'capistrano-sidekiq'
end

group :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
end

gem 'rack-cors', :require => 'rack/cors'
gem 'devise'
gem 'active_model_serializers', :git => 'git://github.com/rails-api/active_model_serializers.git', :ref => 'af280ab'
gem 'kaminari'
gem 'roo', '~> 2.1.0'
gem 'roo-xls'
gem 'has_scope'
gem 'sidekiq'