# frozen_string_literal: true

module Gps
  module Job
    class Worker
      def self.run_worker!
        Gps::Job.configuration.logger.info 'Running worker to lookup book details'
        topic        = pubsub.topic       'lookup_book_details_queue'
        subscription = topic.subscription 'lookup_book_details'
        topic.subscribe 'lookup_book_details' unless subscription.exists?
        subscription.listen autoack: true do |message|
          Gps::Job.configuration.logger.info message.data
        end
      end
    end
  end
end
