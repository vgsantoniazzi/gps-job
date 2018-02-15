# frozen_string_literal: true
require 'test_helper'

class Gps::Job::Worker::Test < Minitest::Test
  def setup
    Gps::Job.configure do |config|
      config.logger = nil
      config.event_name = 'perform.gps_job'
    end
  end

  def test_run_worker
    Gps::Job::Worker.stub(:subscribe_to_google_pub_sub!, mock) do
      Gps::Job::Worker.stub(:subscribe_to_active_support_instrumentation!, mock) do
        Gps::Job::Worker.run_worker!
        mock.verify
      end
    end
  end

  def test_subscribe_to_active_support_instrumentation
    mock.expect(:call, nil, ['perform.gps_job'])
    ActiveSupport::Notifications.stub(:subscribe, mock) do
      Gps::Job::Worker.subscribe_to_active_support_instrumentation!
    end
    mock.verify
  end

  def test_subscribe_to_google_pub_sub!
    mock.expect(:listen, nil, [{autoack: true}])
    Gps::Job::Worker.stub(:subscription, mock) do
      Gps::Job::Worker.subscribe_to_google_pub_sub!
    end
    mock.verify
  end

  def test_perform_job
    mock.expect(:call, nil, ["perform.gps_job", {"class_name"=>"Test", "args"=>[]}])
    ActiveSupport::Notifications.stub(:instrument, mock) do
      Gps::Job::Worker.perform_job({class_name: 'Test', args: []}.to_json.to_s)
    end
    mock.verify
  end
end
