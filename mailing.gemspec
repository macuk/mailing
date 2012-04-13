# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mailing/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors        = ["Piotr Macuk"]
  gem.email          = ["piotr@macuk.pl"]
  gem.description    = %q{Tool for sending fast mailings in one SMTP connection}
  gem.summary        = %q{Fast mailings}
  gem.homepage       = "https://github.com/macuk/mailing"

  gem.files          = `git ls-files`.split($\)
  gem.executables    = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files     = gem.files.grep(%r{^(test|spec|features)/})
  gem.name           = "mailing"
  gem.require_paths  = ["lib"]
  gem.version        = Mailing::VERSION
  gem.add_dependency 'mail', '>= 2.2.5' # The same as Rails 3.0
end
