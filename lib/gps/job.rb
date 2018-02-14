# frozen_string_literal: true

require 'rails'
require 'google/cloud/pubsub'
require 'gps/job/railtie'

module Gps
  module Job
    class << self
      attr_writer :configuration, :metrics

      def configuration
        @configuration ||= Configuration.new
      end

      def metrics
        @metrics ||= Metrics.new
      end
    end

    def self.configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    def self.topic
      pubsub.topic(configuration.queue) || pubsub.create_topic(configuration.queue)
    end

    def self.pubsub
      Google::Cloud.new(
        Gps::Job.configuration.project_id,
        Gps::Job.configuration.credentials
      ).pubsub
    end

    autoload :Configuration, 'gps/job/configuration'
    autoload :Metrics, 'gps/job/metrics'
    autoload :Worker, 'gps/job/worker'
    autoload :Adapter, 'gps/job/adapter'
  end
end
