# frozen_string_literal: true

require 'test_helper'

class Gps::Job::Metrics::Test < Minitest::Test
  def running_metrics
    metrics = Gps::Job::Metrics.new
    metrics.total_duration = 0.1
    metrics.total_count += 2
    metrics
  end

  def test_total_duration_metrics
    assert_equal Gps::Job.metrics.total_duration, 0
    assert_equal running_metrics.total_duration, 0.1
  end

  def test_total_count_metrics
    assert_equal Gps::Job.metrics.total_count, 0
    assert_equal running_metrics.total_count, 2
  end
end
