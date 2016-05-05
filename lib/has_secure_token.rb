require 'active_record'
module ActiveRecord
  module SecureToken
    extend ActiveSupport::Concern

    module ClassMethods
      # Example using #has_secure_token
      #
      #   # Schema: User(token:string, auth_token:string, api_key:string)
      #   class User < ActiveRecord::Base
      #     has_secure_token
      #     has_secure_token :auth_token, prefix: 'ut_'
      #     has_secure_token :api_key,    prefix: 'ak_', length: 42
      #   end
      #
      #   user = User.new
      #   user.save
      #   user.token # => "pX27zsMN2ViQKta1bGfLmVJE"
      #   user.auth_token # => "77TMHrHJFvFDwodq8w7Ev2m7"
      #   user.api_key # => "ak_1wkenr7vcAb9tH1jyQzvBdxBg8jC2bSv8ySM335"
      #   user.regenerate_token # => true
      #   user.regenerate_auth_token # => true
      #
      # <tt>SecureRandom::base58</tt> is used to generate the 24-character unique token, so collisions are highly unlikely.
      #
      # Note that it's still possible to generate a race condition in the database in the same way that
      # {validates_uniqueness_of}[rdoc-ref:Validations::ClassMethods#validates_uniqueness_of] can.
      # You're encouraged to add a unique index in the database to deal with this even more unlikely scenario.
      def has_secure_token(attribute = :token, length: 24, prefix: '')
        # Load securerandom only when has_secure_token is used.
        require 'active_support/core_ext/securerandom'
        define_method("regenerate_#{attribute}") { update! attribute => self.class.generate_unique_secure_token(length, prefix) }
        before_create { self.send("#{attribute}=", self.class.generate_unique_secure_token(length, prefix)) unless self.send("#{attribute}?")}
      end

      def generate_unique_secure_token(length, prefix)
        token_length = length - prefix.length
        prefix + SecureRandom.base58(token_length)
      end
    end
  end
end
ActiveRecord::Base.send(:include, ActiveRecord::SecureToken)