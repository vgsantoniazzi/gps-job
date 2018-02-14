# frozen_string_literal: true

require 'gps/job/adapter'

Rails.application.config.active_job.queue_adapter = :google_cloud_pubsub
