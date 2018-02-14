# frozen_string_literal: true

module Gps
  module Job
    class Worker
      def self.run_worker!
        Gps::Job.configuration.logger.info 'Google Pub/Sub Worker running.'
        subscribe_to_active_support_instrumentation!
        subscribe_to_google_pub_sub!
      end

      def self.subscribe_to_active_support_instrumentation!
        ActiveSupport::Notifications.subscribe(Gps::Job.configuration.event_name) do |_name, started, finished, _unique_id, data|
          Gps::Job.configuration.logger.info "Finished job: #{data}"
          Gps::Job.configuration.metrics[:total_duration] += (finished - started)
          Gps::Job.configuration.metrics[:total_count] += 1
        end
      end

      def self.subscribe_to_google_pub_sub!
        subscription.listen(autoack: true) do |message|
          Gps::Job.configuration.logger.info "Started Job: #{message.data}"
          perform_job(message.data)
        end
      end

      def self.perform_job(data)
        data = JSON.parse(data)
        ActiveSupport::Notifications.instrument(Gps::Job.configuration.event_name, data) do
          data.fetch('class_name').constantize.perform_now(*data.fetch('args'))
        end
      end

      def self.subscription
        Gps::Job.topic.subscription(Gps::Job.configuration.queue) ||
          Gps::Job.topic.subscribe(Gps::Job.configuration.queue)
      end
    end
  end
end
