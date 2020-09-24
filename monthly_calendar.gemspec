# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "monthly_calendar/version"

Gem::Specification.new do |spec|
  spec.name          = "monthly_calendar"
  spec.version       = MonthlyCalendar::VERSION
  spec.authors       = ["Brandon Conway"]
  spec.email         = ["brandoncc@gmail.com"]

  spec.summary       = %q{A simple monthly calendar generator with space for notes}
  spec.homepage      = "http://github.com/brandoncc/monthly_calendar"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "prawn", "~> 2.2"
end
