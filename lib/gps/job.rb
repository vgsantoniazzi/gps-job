# frozen_string_literal: true

require 'rails'
require 'active_job'

module Gps
  module Job
    autoload :Configuration, 'gps/job/configuration'
    autoload :Worker, 'gps/job/worker'
    autoload :Adapter, 'gps/job/adapter'
  end
end
