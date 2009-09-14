# -*- encoding: utf-8 -*-
#require 'date'
Gem::Specification.new do |s|
  s.name = %q{yesradio}
  s.version = "0.0.1"
  s.authors = ["Claudio Baccigalupo"] 
  s.email = %q{claudiob@gmail.com} 
  # s.date = s.date = Date.today.to_s
  s.summary = %q{Ruby library for Yes.com radio Web Services (http://api.yes.com).}
  s.description = %q{YesRadio makes available as a ruby gem the method exposed by Yes.com API to retrieve songs broadcast by thousands of radios.}
  s.files = Dir.glob('**/*')
  s.homepage = %q{http://github.com/claudiob/yesradio}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{yesradio}
  s.rubygems_version = %q{1.3.3}
  s.has_rdoc = true 
  s.extra_rdoc_files = ["README.md"]
end