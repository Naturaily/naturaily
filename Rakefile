# encoding: utf-8

require "rubygems"
require "hoe"

Hoe.plugin :git
Hoe.plugin :gemspec
Hoe.plugin :debugging
Hoe.plugin :minitest

Hoe.spec "naturaily" do
  developer("Przemysław Lusar", "przemyslaw.lusar@naturaily.com")

  license "MIT"
  self.readme_file = "README.md"
  self.summary = "Naturaily gem, providing custom helpers and development utilities for our projects."
  self.urls = {'home' => 'https://github.com/Naturaily/naturaily'}

  dependency 'capistrano', "~> 2.0"
  dependency 'colored', "~> 1.2"
end
