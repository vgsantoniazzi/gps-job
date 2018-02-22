# frozen_string_literal: true

module Gps
  module Job
    class Worker
      def self.run_worker!
        Gps::Job.configuration.logger&.info 'Google Pub/Sub Worker running.'
        subscribe_to_active_support_instrumentation!
        subscribe_to_google_pub_sub!
      end

      def self.subscribe_to_active_support_instrumentation!
        ActiveSupport::Notifications.subscribe(Gps::Job.configuration.event_name) do |_name, started, finished, _unique_id, data|
          Gps::Job.configuration.logger&.info "Finished job: #{data}"
          Gps::Job.metrics.total_duration += (finished - started)
          Gps::Job.metrics.total_count += 1
        end
      end

      def self.subscribe_to_google_pub_sub!
        subscription.listen do |message|
          data = JSON.parse(message.data)
          if perform_now?(data)
            message.acknowledge!
            perform_job(data)
          end
        end
      end

      def self.perform_now?(data)
        data['at'].to_i < Time.now.to_i
      end

      def self.perform_job(data)
        Gps::Job.configuration.logger&.info "Started Job: #{data}"
        ActiveSupport::Notifications.instrument(Gps::Job.configuration.event_name, data) do
          data.fetch('job_class').constantize.perform_now(*data.fetch('arguments'))
        end
      end

      def self.subscription
        Gps::Job.topic.subscription(Gps::Job.configuration.queue) ||
          Gps::Job.topic.subscribe(Gps::Job.configuration.queue)
      end
    end
  end
end
