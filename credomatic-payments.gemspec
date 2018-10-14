
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "credomatic/payments/version"

Gem::Specification.new do |spec|
  spec.name          = "credomatic-payments"
  spec.version       = Credomatic::Payments::VERSION
  spec.authors       = ["David Cortes"]
  spec.email         = ["dcortes22@gmail.com"]

  spec.summary       = %q{Manejo de pagos Credomatic Costa Rica}
  spec.description   = %q{Realice pagos desde su sitio web con Credomatic Gateway.}
  spec.homepage      = "http://www.davidcortes.cr"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"

  spec.files        = `git ls-files`.split("\n")
end
