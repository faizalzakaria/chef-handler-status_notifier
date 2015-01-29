# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chef/handler/status_notifier/version'

Gem::Specification.new do |spec|
  spec.name          = "chef-handler-status_notifier"
  spec.version       = Chef::Handler::StatusNotifier::VERSION
  spec.authors       = ["Faizal Zakaria"]
  spec.email         = ["phaibusiness@gmail.com"]
  spec.summary       = %q{Chef status notifier handler}
  spec.description   = %q{Chef status notifier handler}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  s.add_runtime_dependency "hipchat"
  s.add_runtime_dependency "slack-notifier"
end
