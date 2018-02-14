# frozen_string_literal: true

module Gps
  module Job
    class Metrics
      attr_accessor :total_duration, :total_count

      def initialize
        @total_duration = 0
        @total_count = 0
      end
    end
  end
end
