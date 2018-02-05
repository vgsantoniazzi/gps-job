# frozen_string_literal: true

module Gps
  module Job
    class Worker
      def self.run_worker!
        Gps::Job.configuration.logger.info 'Google Pub/Sub Worker running.'
        subscription = Gps::Job.topic.subscription(Gps::Job.configuration.queue)
        subscription ||= Gps::Job.topic.subscribe(Gps::Job.configuration.queue)
        subscription.listen(autoack: true) do |message|
          Gps::Job.configuration.logger.info(message.inspect)
        end
      end
    end
  end
end
