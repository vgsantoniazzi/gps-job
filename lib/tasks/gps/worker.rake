# frozen_string_literal: true

require 'gps/job'

namespace :gps do
  task :worker do
    Rails.application.initialize! if defined?(Rails)
    Gps::Job::Worker.run_worker!
  end
end
