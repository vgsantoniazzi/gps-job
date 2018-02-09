# frozen_string_literal: true

module ActiveJob
  module QueueAdapters
    class GoogleCloudPubsubAdapter
      def enqueue(job)
        Gps::Job.configuration.logger.info "Google Pub/Sub Enqueued job #{job.inspect}"
        Gps::Job.topic.publish({ class_name: job.class.to_s, args: job.arguments }.to_json.to_s)
      end
    end
  end
end
