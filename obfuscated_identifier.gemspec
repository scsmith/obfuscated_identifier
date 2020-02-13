lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'obfuscated_identifier/version'

Gem::Specification.new do |spec|
  spec.name          = "obfuscated_identifier"
  spec.version       = ObfuscatedIdentifier::VERSION
  spec.authors       = ["Steve Smith"]
  spec.email         = ["github@scsworld.co.uk"]
  spec.description   = %q{Obfuscate your Rails primary key}
  spec.summary       = %q{Hide your Rails primary key without the need for token generation and additional index space.}
  spec.homepage      = "https://github.com/scsmith/obfuscated_identifier"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "activesupport", ">= 4.1.11"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
