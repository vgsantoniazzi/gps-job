# frozen_string_literal: true

class GreetingJob < ApplicationJob
  def perform(name)
    print "Hi #{name}"
  end
end
