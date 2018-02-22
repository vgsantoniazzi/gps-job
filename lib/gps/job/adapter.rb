# frozen_string_literal: true

module ActiveJob
  module QueueAdapters
    class GoogleCloudPubsubAdapter
      def enqueue(job, attributes = {})
        Gps::Job.configuration.logger&.info "Google Pub/Sub Enqueued job #{job.inspect}"
        Gps::Job.topic.publish(job_data(job, attributes).to_json)
      end

      def enqueue_at(job, timestamp)
        enqueue(job, timestamp: timestamp)
      end

      private

      def job_data(job, attributes)
        info = job.serialize
        info['at'] = attributes[:timestamp] if attributes[:timestamp].to_i > Time.now.to_i
        info
      end
    end
  end
end
