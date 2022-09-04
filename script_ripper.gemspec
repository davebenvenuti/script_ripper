
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "script_ripper/version"

Gem::Specification.new do |spec|
  spec.name          = "script_ripper"
  spec.version       = ScriptRipper::VERSION
  spec.authors       = ["Dave Benvenuti"]
  spec.email         = ["davebenvenuti@gmail.com"]

  spec.summary       = %q{Rip shell scripts out of instructional web pages}
  spec.homepage      = "https://github.com/davebenvenuti/script_ripper"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/davebenvenuti/script_ripper"
    # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "nokogiri", "~> 1.13"

  spec.add_development_dependency "bundler", "~> 2.3"
  spec.add_development_dependency "debug", "~> 1.6"
  spec.add_development_dependency "minitest", "~> 5.16"
  spec.add_development_dependency "mocha", "~> 1.14"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "vcr", "6.1.0"
  spec.add_development_dependency "webmock", "~> 3.18"
end
