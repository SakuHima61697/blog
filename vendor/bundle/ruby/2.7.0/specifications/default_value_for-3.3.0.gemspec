# -*- encoding: utf-8 -*-
# stub: default_value_for 3.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "default_value_for".freeze
  s.version = "3.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Hongli Lai".freeze]
  s.date = "2019-08-20"
  s.description = "The default_value_for plugin allows one to define default values for ActiveRecord models in a declarative manner".freeze
  s.email = "software-signing@phusion.nl".freeze
  s.homepage = "https://github.com/FooBarWidget/default_value_for".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Provides a way to specify default values for ActiveRecord models".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<activerecord>.freeze, [">= 3.2.0", "< 6.1"])
    s.add_development_dependency(%q<actionpack>.freeze, [">= 3.2.0", "< 6.1"])
    s.add_development_dependency(%q<railties>.freeze, [">= 3.2.0", "< 6.1"])
    s.add_development_dependency(%q<minitest>.freeze, [">= 4.2"])
    s.add_development_dependency(%q<minitest-around>.freeze, [">= 0"])
    s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
  else
    s.add_dependency(%q<activerecord>.freeze, [">= 3.2.0", "< 6.1"])
    s.add_dependency(%q<actionpack>.freeze, [">= 3.2.0", "< 6.1"])
    s.add_dependency(%q<railties>.freeze, [">= 3.2.0", "< 6.1"])
    s.add_dependency(%q<minitest>.freeze, [">= 4.2"])
    s.add_dependency(%q<minitest-around>.freeze, [">= 0"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
  end
end
