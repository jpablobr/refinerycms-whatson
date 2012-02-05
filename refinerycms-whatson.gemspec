Gem::Specification.new do |s|
  s.name              = %q{refinerycms-whatson}
  s.version           = %q{1.8.0}
  s.description       = %q{Straightforward what\'s on engine for RefineryCMS.}
  s.date              = %q{2012-02-05}
  s.summary           = %q{Ruby on Rails what\'s on engine for RefineryCMS.}
  s.email             = %q{xjpablobrx@gmail.com}
  s.homepage          = %q{http://github.com/jpablobr/refinerycms-whatson}
  s.authors           = ['Jose Pablo Barrantes']
  s.add_dependency    'refinerycms-core',   '~> 1.0.3'
  s.add_dependency    'filters_spam',       '~> 0.2'
  s.add_dependency    'acts-as-taggable-on'
  s.add_dependency    'seo_meta',           '~> 1.1.0'
  s.add_development_dependency 'factory_girl'
  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path  = 'lib'
end
