# frozen_string_literal: true

module Gps
  module Job
    class Configuration
      attr_accessor :logger, :queue, :project_id, :credentials, :event_name, :metrics

      def initialize
        @logger = Logger.new(STDOUT)
        @queue = :default
        @project_id = :default
        @credentials = '~/.google/keyfile.json'
        @event_name = 'perform.gps_job'
        @metrics = { total_duration: 0, total_count: 0 }
      end
    end
  end
end
