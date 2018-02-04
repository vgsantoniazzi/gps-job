# frozen_string_literal: true

require 'test_helper'

class Gps::Job::Test < Minitest::Test
  def setup
    Gps::Job.configure do |config|
      config.retries = 10
      config.min_threads = 2
      config.max_threads = 3
    end
  end

  def test_retries_configuration
    assert_equal Gps::Job.configuration.retries, 10
  end
end
