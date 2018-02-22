# frozen_string_literal: true

require 'gps/job/adapter'

Rails.application.config.active_job.queue_adapter = :google_cloud_pubsub

Gps::Job.configure do |config|
  config.queue = 'default'
  config.project_id = 'gps-job-test'
  config.credentials = '/home/vgsantoniazzi/.google/keyfile.json'
end
