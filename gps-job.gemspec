# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'gps/job/version'

Gem::Specification.new do |s|
  s.name        = 'gps-job'
  s.version     = Gps::Job::VERSION
  s.authors     = ['Victor Antoniazzi']
  s.email       = ['vgsantoniazzi@gmail.com']
  s.homepage    = 'http://github.com/vgsantoniazzi/gps-job'
  s.summary     = 'Google Pub/Sub Active Job Adapter'
  s.description = 'Google Pub/Sub Active Job Adapter'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.add_dependency 'google-api-client',   '~> 0.19.5'
  s.add_dependency 'rails',               '~> 5.1.4'
  s.add_dependency 'google-cloud-pubsub', '~> 0.21.0'
end
