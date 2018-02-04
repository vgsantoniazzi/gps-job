# frozen_string_literal: true

module Gps
  module Job
    class Adapter
      def self.enqueue(job)
        Gps::Job.configuration.logger.info "Enqueued job #{job.inspect}"
        book  = job.arguments.first
        topic = pubsub.topic 'lookup_book_details_queue'
        topic.publish book.id.to_s
      end
    end
  end
end

ActiveJob::QueueAdapters::GoogleCloudPubsubAdapter = Gps::Job::Adapter
