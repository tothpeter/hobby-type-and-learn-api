# Type and Learn API

[The main project page](https://github.com/tothpeter/type_and_learn)

This is the API of my home project called Type and Learn.

A broader description is on its way...

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

### Airbrake config

In production Airbrake requires an initializer like this:

```
# file: shared/config/initializers/airbrake.rb
Airbrake.configure do |config|
  config.api_key = ''
  config.host    = ''
  config.port    = 443
  config.secure  = config.port == 443
  config.ignore_only = []
  config.ignore_user_agent  << /bot/
end
```