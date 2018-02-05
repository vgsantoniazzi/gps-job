# frozen_string_literal: true

module Gps
  module Job
    class Railtie < Rails::Railtie
      rake_tasks do
        load 'tasks/gps/worker.rake'
      end
    end
  end
end
