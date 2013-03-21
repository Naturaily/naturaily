# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "naturaily"
  s.version = "0.1.0.20130321144404"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Przemys\u{142}aw Lusar"]
  s.date = "2013-03-21"
  s.description = ""
  s.email = ["przemyslaw.lusar@naturaily.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt"]
  s.files = [".autotest", ".gemtest", "History.txt", "Manifest.txt", "README.md", "Rakefile", "lib/naturaily.rb", "lib/naturaily/capistrano.rb", "lib/naturaily/recipes/common.rb", "lib/naturaily/recipes/faye.rb", "lib/naturaily/recipes/git.rb", "lib/naturaily/recipes/rapns.rb", "lib/naturaily/recipes/unicorn.rb", "lib/naturaily/recipes/version_manager.rb", "naturaily.gemspec", "test/test_naturaily.rb"]
  s.homepage = "https://github.com/Naturaily/naturaily"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "naturaily"
  s.rubygems_version = "1.8.23"
  s.summary = "Naturaily gem, providing custom helpers and development utilities for our projects."
  s.test_files = ["test/test_naturaily.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capistrano>, ["~> 2.0"])
      s.add_runtime_dependency(%q<colored>, ["~> 1.2"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_development_dependency(%q<hoe>, ["~> 3.5"])
    else
      s.add_dependency(%q<capistrano>, ["~> 2.0"])
      s.add_dependency(%q<colored>, ["~> 1.2"])
      s.add_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_dependency(%q<hoe>, ["~> 3.5"])
    end
  else
    s.add_dependency(%q<capistrano>, ["~> 2.0"])
    s.add_dependency(%q<colored>, ["~> 1.2"])
    s.add_dependency(%q<rdoc>, ["~> 3.10"])
    s.add_dependency(%q<hoe>, ["~> 3.5"])
  end
end
