# frozen_string_literal: true

require 'minitest'
require 'minitest/autorun'
require 'pry-byebug'
require 'gps/job'
require 'gps/job/adapter'

def mock
  @mock ||= MiniTest::Mock.new
end
