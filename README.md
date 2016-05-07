[![Build Status](https://travis-ci.org/ecleel/super_token.svg?branch=master)](https://travis-ci.org/ecleel/super_token)
[![Gem Version](https://badge.fury.io/rb/super_token.svg)](https://badge.fury.io/rb/super_token)
[![Dependency Status](https://gemnasium.com/robertomiranda/has_secure_token.svg)](https://gemnasium.com/ecleel/super_token)
[![Code Climate](https://codeclimate.com/github/ecleel/super_token/badges/gpa.svg)](https://codeclimate.com/github/ecleel/super_token)
[![Test Coverage](https://codeclimate.com/github/ecleel/super_token/badges/coverage.svg)](https://codeclimate.com/github/ecleel/super_token/coverage)

# SuperToken

SuperToken is a fork of HasSecureToken module and add more options to create token like prefix string and change length.

**Note** If you're worried about possible collissions, there's a way to generate a race condition in the database in the same way that [validates_uniqueness_of](http://api.rubyonrails.org/classes/ActiveRecord/Validations/ClassMethods.html) can. You're encouraged to add an unique index in the database to deal with this even more unlikely scenario.

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
# Schema: User(token:string, auth_token:string)
class APIKey < ActiveRecord::Base
  has_secure_token
end

api_key = APIKey.new
api_key.save
api_key.token # => "pX27zsMN2ViQKta1bGfLmVJE"
api_key.regenerate_token # => true
```

To use a custom column to store the token key field you can specify the column_name option. See example above (e.g: auth_token):

```ruby
# Schema: User(token:string, auth_token:string)
class APIKey < ActiveRecord::Base
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
5 runs, 9 assertions, 0 failures, 0 errors, 0 skips
```

## Contributing

1. Fork it ( https://github.com/robertomiranda/has_secure_token/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
