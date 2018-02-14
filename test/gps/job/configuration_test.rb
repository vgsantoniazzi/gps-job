# frozen_string_literal: true

require 'test_helper'

class Gps::Job::Configuration::Test < Minitest::Test
  def default_configuration
    Gps::Job::Configuration.new
  end

  def setup
    Gps::Job.configure do |config|
      config.logger = nil
      config.queue = 'queue-1'
      config.project_id = 'gps-job-production'
      config.credentials = '/etc/env/keyfile.json'
      config.event_name = 'gps_job.finished'
    end
  end

  def test_logger_configuration
    assert_kind_of Logger, default_configuration.logger
    assert_kind_of NilClass, Gps::Job.configuration.logger
  end

  def test_queue_configuration
    assert_equal default_configuration.queue, :default
    assert_equal Gps::Job.configuration.queue, 'queue-1'
  end

  def test_project_id_configuration
    assert_equal default_configuration.project_id, :default
    assert_equal Gps::Job.configuration.project_id, 'gps-job-production'
  end

  def test_credentials_configuration
    assert_equal default_configuration.credentials, '~/.google/keyfile.json'
    assert_equal Gps::Job.configuration.credentials, '/etc/env/keyfile.json'
  end

  def test_event_name_configuration
    assert_equal default_configuration.event_name, 'perform.gps_job'
    assert_equal Gps::Job.configuration.event_name, 'gps_job.finished'
  end
end
