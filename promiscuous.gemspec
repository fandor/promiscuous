# encoding: utf-8
$:.unshift File.expand_path("../lib", __FILE__)
$:.unshift File.expand_path("../../lib", __FILE__)

require 'promiscuous/version'

Gem::Specification.new do |s|
  s.name        = "promiscuous"
  s.version     = Promiscuous::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nicolas Viennot", "Kareem Kouddous"]
  s.email       = ["nicolas@viennot.biz", "kareem@doubleonemedia.com"]
  s.homepage    = "http://github.com/crowdtap/promiscuous"
  s.summary     = "Replicate models across applications"
  s.description = "Replicate models across applications"

  s.executables   = ['promiscuous']


  #100beta6
  s.add_dependency "activesupport",       "~> 4.2.5"
  s.add_dependency "activemodel",         "~> 4.2.5"
  s.add_dependency "bunny",               "~> 2.0"
  s.add_dependency "amq-protocol",        "~> 2.0.1"
  s.add_dependency "ruby-progressbar",    "~> 1.7.5"
  s.add_dependency "redis",               "~> 3.2.0"
  s.add_dependency "algorithms",          "~> 0.6.1"
  s.add_dependency "fnv",                 "0.2.0"
  s.add_dependency "multi_json",          "~> 1.11"
  s.add_dependency "robust-redis-lock",   "~> 1.3"


  # #100beta6 orig
  # s.add_dependency "activesupport",       ">= 3"
  # s.add_dependency "activemodel",         ">= 3"
  # s.add_dependency "bunny",               ">= 0.10.7"
  # s.add_dependency "amq-protocol",        ">= 1.8.0"
  # s.add_dependency "ruby-progressbar",    "~> 1.2.0"
  # s.add_dependency "redis",               "~> 3.0"
  # s.add_dependency "algorithms",          "~> 0.6.1"
  # s.add_dependency "fnv",                 "0.2.0"
  # s.add_dependency "multi_json",          "~> 1.8.0"
  # s.add_dependency "robust-redis-lock",   "~> 0.2.2"

  #master_fandor
  # s.add_dependency "activesupport",       "~> 4.2.5"
  # s.add_dependency "activemodel",         "~> 4.2.5"
  # s.add_dependency "bunny",               "~> 2.0"
  # s.add_dependency "amq-protocol",        ">= 1.9.2"  #"~> 2.0.1"
  # s.add_dependency "ruby-progressbar",    "~> 1.7.5"
  # s.add_dependency "redis",               "~> 3.2.0"
  # s.add_dependency "algorithms",          "~> 0.6.1"
  # s.add_dependency "fnv",                 "0.2.0"
  # s.add_dependency "multi_json",          "~> 1.11"
  # s.add_dependency "robust-redis-lock",   "~> 1.3"


  s.files        = Dir["lib/**/*"] + Dir["bin/**/*"]
  s.require_path = 'lib'
  s.has_rdoc     = false
end
