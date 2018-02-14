# frozen_string_literal: true

require 'test_helper'

class Gps::Job::Test < Minitest::Test
  def test_version_number
    assert_equal Gps::Job::VERSION, '0.1.0'
  end
end
