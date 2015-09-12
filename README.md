# Type and Learn API

This is the API backend of my home project called Type and Learn.

The frontend will come soon here in github and in production as well.

The full project will be deployed to here: http://type-and-learn.kalina.tech

## Ruby version
2.2.3

## System dependencies
## Configuration
## Database creation
```
rake db:create
rake db:migrate
```

## How to run the test suite
```
bundle exec rspec
```

## Services (job queues, cache servers, search engines, etc.)
## Deployment instructions
```
bundle exec cap production deploy
```

### Airbarke config

If you want to use Airbrake in production then you should create a file: shared/config/initializers/airbrake.rb

```
Airbrake.configure do |config|
  config.api_key = ''
  config.host    = ''
  config.port    = 443
  config.secure  = config.port == 443
  config.ignore_only = []
end
```