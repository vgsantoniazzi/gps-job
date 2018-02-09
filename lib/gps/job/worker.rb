# frozen_string_literal: true

module Gps
  module Job
    class Worker
      def self.run_worker!
        Gps::Job.configuration.logger.info 'Google Pub/Sub Worker running.'
        subscription.listen(autoack: true) do |message|
          Gps::Job.configuration.logger.info(message.inspect)
          data = JSON.parse(message.data)
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
