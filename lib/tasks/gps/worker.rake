# frozen_string_literal: true

require 'gps/job'

namespace :gps do
  task :worker do
    Gps::Job::Worker.run_worker!
  end
end
