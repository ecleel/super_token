[![Build Status](https://travis-ci.org/ecleel/super_token.svg?branch=master)](https://travis-ci.org/ecleel/super_token)
[![Gem Version](https://badge.fury.io/rb/super_token.svg)](https://badge.fury.io/rb/super_token)
[![Dependency Status](https://gemnasium.com/ecleel/super_token.svg)](https://gemnasium.com/ecleel/super_token)
[![Code Climate](https://codeclimate.com/github/ecleel/super_token/badges/gpa.svg)](https://codeclimate.com/github/ecleel/super_token)
[![Test Coverage](https://codeclimate.com/github/ecleel/super_token/badges/coverage.svg)](https://codeclimate.com/github/ecleel/super_token/coverage)

# SuperToken

SuperToken is a fork of [HasSecureToken](https://github.com/robertomiranda/has_secure_token) module which is provides an easy way to generate uniques random tokens for any model in ruby on rails. SuperToken gives you a way to prefix token with string and change token length. 

## Installation

Add this line to your application's Gemfile:

    gem 'super_token'

And then run:

    $ bundle

Or install it yourself as:

    $ gem install super_token

## Setting your Model

The first step is to generate a migration in order to add the token key field.

```ruby
rails g migration AddTokenToAPIKey token:string secret_key:string public_key:string
=>
   invoke  active_record
   create    db/migrate/20150424010931_add_token_to_api_key_.rb
```

Then run `rake db:migrate` in order to update users table in the database. The next step is to add `has_secure_token`
 to the model:
```ruby
# Schema: APIKey(token:string, secret_key:string, public_key:string)
class APIKey < ActiveRecord::Base
  has_secure_token
end

# test regular has_secure_token features
api_key = APIKey.new
api_key.save
api_key.token # => "pX27zsMN2ViQKta1bGfLmVJE"
api_key.regenerate_token # => true
```

To use a custom column to store the token key field you can specify the column_name option. See example above (e.g: auth_token):

```ruby
# Schema: APIKey(token:string, secret_key:string, public_key:string)
class APIKey < ActiveRecord::Base
  # super_token add two options for has_secure_token (prefix and length)
  has_secure_token :secret_key, prefix: 'sk_', length: 48
  has_secure_token :public_key, prefix: 'pk_', length: 48
end


api_key = APIKey.new
api_key.save
api_key.secret_key # => "sk_pX27zsMN2ViQKta1bGfLmVJEiQKta1bGfLmVJE"
api_key.public_key # => "pk_pX27zsMN2ViQKta1bGfLmVJEiQKta1bGfLmVJE"
api_key.regenerate_secret_key # => true
```

## Running tests

Running

```shell
$ rake test
```

Should return

```shell
9 runs, 17 assertions, 0 failures, 0 errors, 0 skips
```

## Contributing

1. Fork it ( https://github.com/ecleel/super_token/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
