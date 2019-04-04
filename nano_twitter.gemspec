
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nano_twitter/version"

Gem::Specification.new do |spec|
  spec.name          = "nano_twitter"
  spec.version       = NanoTwitter::VERSION
  spec.authors       = ["Ari Carr"]
  spec.email         = ["acarr@brandeis.edu"]

  spec.summary       = "A client gem for NanoTwitter, our COSI 105B project"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "httparty"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rb-readline"
end
