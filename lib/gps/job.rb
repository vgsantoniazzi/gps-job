# frozen_string_literal: true

require 'rails'
require 'active_job'

module Gps
  module Job
    class << self
      attr_writer :configuration

      def configuration
        @configuration ||= Configuration.new
      end
    end

    def self.configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    class Configuration
      attr_accessor :retries, :logger, :queue, :max_threads, :min_threads,
                    :retry_every

      def initialize
        @retries = 3
        @retry_every = 2.minutes
        @logger = Logger.new(STDOUT)
        @queue = :default
        @max_threads = 1
        @min_threads = 1
      end
    end

    autoload :Adapter, 'gps/job/adapter'
    autoload :Worker, 'gps/job/worker'
  end
end

ActiveJob::QueueAdapters.autoload :GoogleCloudPubsubAdapter, 'gps/job/adapter'
