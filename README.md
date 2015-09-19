# Type and Learn API

This is the API backend of my home project called Type and Learn.

The frontend is an Ember CLI application: https://github.com/tothpeter/type_and_learn_client

I'm running this project on my private Ubuntu server in my living room.

There is a third app, that is in charge to bootstrap the whole project in production: https://github.com/tothpeter/type_and_learn_web

The final app is live here: http://type-and-learn.kalina.tech

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
end
```