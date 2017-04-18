# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thumbnailer/version'

Gem::Specification.new do |spec|
  spec.name          = "thumbnailer-taq"
  spec.version       = Thumbnailer::VERSION
  spec.authors       = ["Eustáquio Rangel"]
  spec.email         = ["taq@eustaquiorangel.com"]

  spec.summary       = %q{A simple way to create thumbnails.}
  spec.homepage      = "http://github.com/taq/thumbnailer"
  spec.licenses      = [ 'GPL-2.0' ]

  spec.signing_key   = '/home/taq/.gemcert/gem-private_key.pem'
  spec.cert_chain    = ['gem-public_cert.pem']

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "mini_magick", "~> 4.7"
end
