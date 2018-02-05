# frozen_string_literal: true

module ActiveJob
  module QueueAdapters
    class GoogleCloudPubsubAdapter
      def enqueue(job)
        Gps::Job.configuration.logger.info "Google Pub/Sub Enqueued job #{job.inspect}"
        Gps::Job.topic.publish job.to_json
      end
    end
  end
end
