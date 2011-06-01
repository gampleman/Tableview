# -*- encoding: utf-8 -*-
require File.expand_path("../lib/tableview/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "tableview"
  s.version     = Tableview::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jakub Hampl"]
  s.email       = ["honitom@seznam.cz"]
  s.homepage    = "http://rubygems.org/gems/tableview"
  s.summary     = "Tableview is a DSL for specifying tables in Rails views that can output in multiple formats"
  s.description = "Supported formats are ASCII, MS Excel, HTML and CSV; it is easy to create your own exporter class."

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "tableview"

  s.add_development_dependency "bundler", ">= 1.0.0"
  
  s.add_dependency "terminal-table", "~> 1.4"
  s.add_dependency "spreadsheet", "~> 0.6"
  s.add_dependency "railties", "~> 3.0"
  #s.add_dependency "thor",     "~> 0.14"
  #s.add_dependency "rails", "~> 3.0"
  
  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
