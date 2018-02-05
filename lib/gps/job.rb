# frozen_string_literal: true

require 'rails'
require 'google/cloud/pubsub'

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

    autoload :Configuration, 'gps/job/configuration'
    autoload :Worker, 'gps/job/worker'
    autoload :Adapter, 'gps/job/adapter'
  end
end
