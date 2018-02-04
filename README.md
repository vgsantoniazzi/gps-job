# Google Pub/Sub job  

Google Cloud Pub/Sub adapter and worker for ActiveJob.

## Usage

```ruby
gem 'gps-job'
```

First, change the ActiveJob backend.

``` ruby
Rails.application.config.active_job.queue_adapter = :google_pubsub
```

Write the Job class and code to use it.

``` ruby
class MyJob < ApplicationJob
  def perform(name)
    puts "How are you?"
  end
end
```

## Google Pub/Sub Emulator

https://cloud.google.com/pubsub/docs/emulator

``` sh
$ gcloud beta emulators pubsub start
```

## Contributing

``` sh
$ bin/setup
```

I :heart: Open source!

[Follow github guides for forking a project](https://guides.github.com/activities/forking/)

[Follow github guides for contributing open source](https://guides.github.com/activities/contributing-to-open-source/#contributing)

## Code Status

[![Build Status](https://travis-ci.org/vgsantoniazzi/gps-job.svg?branch=master)](https://travis-ci.org/vgsantoniazzi/gps-job)

## License

Gem is released under the [MIT license](http://opensource.org/licenses/MIT).
