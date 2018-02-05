# frozen_string_literal: true

module Gps
  module Job
    class Configuration
      attr_accessor :retries, :logger, :queue, :retry_every, :project_id,
                    :credentials

      def initialize
        @retries = 3
        @retry_every = 2.minutes
        @logger = Logger.new(STDOUT)
        @queue = :default
        @project_id = :default
        @credentials = '~/.google/keyfile.json'
      end
    end
  end
end
