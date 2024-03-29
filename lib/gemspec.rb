#!/usr/bin/env ruby
require File.expand_path('../refinery/whatson/version', __FILE__)
version = ::Refinery::Whatson::Version.to_s
raise "Could not get version so gemspec can not be built" if version.nil?
files = Dir.glob("**/*").flatten.reject{|f| f =~ %r{.(gem|lock)$}}

gemspec = <<EOF
Gem::Specification.new do |s|
  s.name              = %q{refinerycms-whatson}
  s.version           = %q{#{version}}
  s.description       = %q{A really straightforward open source Ruby on Rails whatson engine designed for integration with RefineryCMS.}
  s.date              = %q{#{Time.now.strftime('%Y-%m-%d')}}
  s.summary           = %q{Ruby on Rails whatsonging engine for RefineryCMS.}
  s.email             = %q{info@refinerycms.com}
  s.homepage          = %q{http://refinerycms.com/whatson}
  s.authors           = ['Resolve Digital', 'Neoteric Design']
  s.require_paths     = %w(lib)

  # Runtime dependencies
  s.add_dependency    'refinerycms-core',   '~> 1.0.3'
  s.add_dependency    'filters_spam',       '~> 0.2'
  s.add_dependency    'acts-as-taggable-on'
  s.add_dependency    'seo_meta',           '~> 1.1.0'

  # Development dependencies
  s.add_development_dependency 'factory_girl'

  s.files             = %w(
    #{files.join("\n    ")}
  )
  #{"s.test_files        = %w(
    #{Dir.glob("test/**/*.rb").join("\n    ")}
  )" if File.directory?("test")}
end
EOF

File.open(File.expand_path("../../refinerycms-whatson.gemspec", __FILE__), 'w').puts(gemspec)
