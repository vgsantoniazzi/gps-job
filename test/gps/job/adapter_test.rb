# frozen_string_literal: true

require 'test_helper'

class ActiveJob::QueueAdapters::GoogleCloudPubsubAdapter::Test < Minitest::Test
  def setup
    Gps::Job.configure do |config|
      config.logger = nil
    end
  end

  def test_enqueue
    mock.expect(:publish, nil, [{ job_class: 'GreetingJob', arguments: ['victor'] }.to_json.to_s])
    Gps::Job.stub(:topic, mock) do
      ActiveJob::QueueAdapters::GoogleCloudPubsubAdapter.new.enqueue(
        Struct.new(:serialize).new(Struct.new(:job_class, :arguments).new('GreetingJob', ['victor'])), {}
      )
    end
    mock.verify
  end

  def test_enqueue_at
    mock.expect(:publish, nil, [{ job_class: 'GreetingJob', arguments: ['victor'] }.to_json.to_s])
    Gps::Job.stub(:topic, mock) do
      ActiveJob::QueueAdapters::GoogleCloudPubsubAdapter.new.enqueue_at(
        Struct.new(:serialize).new(Struct.new(:job_class, :arguments).new('GreetingJob', ['victor'])), 9999
      )
    end
    mock.verify
  end
end
