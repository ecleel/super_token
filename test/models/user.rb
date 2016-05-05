class User < ActiveRecord::Base
  has_secure_token
  has_secure_token :auth_token, prefix: 'ut_'
  has_secure_token :api_key,    prefix: 'ak_', length: 42
end
