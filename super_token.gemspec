# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'super_token/version'

Gem::Specification.new do |spec|
  spec.name          = "super_token"
  spec.version       = SuperToken::VERSION
  spec.authors       = ["Roberto Miranda Altamar", "Abdulaziz Alshetwi"]
  spec.email         = ["rjmaltamar@gmail.com", "e@ecleel.com"]
  spec.summary       = %q{HasSecureToken with more options}
  spec.description   = %q{SecureToken provides you an easily way to geneatre uniques random tokens for any model in ruby on rails. **SecureRandom::base58** is used to generate the 24-character unique token, so collisions are highly unlikely.}
  spec.homepage      = "https://github.com/ecleel/super_token"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 3.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency 'sqlite3'
end
