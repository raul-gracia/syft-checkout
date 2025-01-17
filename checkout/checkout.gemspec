require_relative 'lib/checkout/version'

Gem::Specification.new do |spec|
  spec.name          = 'checkout'
  spec.version       = Checkout::VERSION
  spec.authors       = ['Raul Gracia']
  spec.email         = ['raulgracialario@gmail.com']

  spec.summary       = 'Checkout'
  spec.description   = 'Checkout'
  spec.homepage      = 'http://github.com/raul-gracia/syft-checkout'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'http://github.com/raul-gracia/syft-checkout'
  spec.metadata['changelog_uri'] = 'http://github.com/raul-gracia/syft-checkout'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '~> 6.0', '>= 6.0.3.4'
  spec.add_runtime_dependency 'yaml', '~> 0.1.0'
end
