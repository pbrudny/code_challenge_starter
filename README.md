# Cron Expression Parser

This is a program which parses a cron string and expands each field to show the times at which it will run.

## Setup
- Install Ruby 2.7.0

- Install Bundler

  `$ gem install bundler`

### Install gems

  `$ bundle install`

## Running

  `$ ruby cron_parser.rb "*/15 0 1,15 * 1-5 /usr/bin/find"`

## Testing

You can test parser using Minitest.

  `$ ruby test/display_test.rb`
  `$ ruby test/parse_test.rb`

## Copyright

Copyright (c) Piotr Brudny.