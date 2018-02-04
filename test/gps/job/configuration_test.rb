# frozen_string_literal: true

require 'test_helper'

class Gps::Job::Configuration::Test < Minitest::Test
  def default_configuration
    Gps::Job::Configuration.new
  end

  def setup
    Gps::Job.configure do |config|
      config.retries = 10
      config.min_threads = 2
      config.max_threads = 3
      config.retry_every = 10.minutes
    end
  end

  def test_retries_configuration
    assert_equal default_configuration.retries, 3
    assert_equal Gps::Job.configuration.retries, 10
  end

  def test_min_threads_configuration
    assert_equal default_configuration.min_threads, 1
    assert_equal Gps::Job.configuration.min_threads, 2
  end

  def test_max_threads_configuration
    assert_equal default_configuration.max_threads, 1
    assert_equal Gps::Job.configuration.max_threads, 3
  end

  def test_retry_every_configuration
    assert_equal default_configuration.retry_every, 2.minutes
    assert_equal Gps::Job.configuration.retry_every, 10.minutes
  end
end
