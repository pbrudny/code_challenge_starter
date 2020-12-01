require 'pry'
require_relative '../lib/validator'
require_relative '../lib/parse'

module CronParser
  class Display
    def initialize(cron_expression)
      self.cron_expression = cron_expression
    end

    def output
      return 'invalid cron expression' unless valid?

      "#{format('minute')}" + "#{minute_result}\n"\
      "#{format('hour')}" + "#{hour_result}\n"\
      "#{format('day of month')}" + "#{day_of_month_result}\n"\
      "#{format('month')}" + "#{month_result}\n"\
      "#{format('day of week')}" + "#{day_of_week_result}\n"\
      "#{format('command')}" + "#{command_result}"
    end

    def valid?
      CronParser::Validator.new(cron_expression).call
    rescue
      false
    end

    def parse(value, top)
      CronParser::Parse.new(value, top).call
    end

    def minute_result
      return 'invalid' unless valid?

      minute = cron_expression.split[0]
      parse(minute, 59)
    end

    def hour_result
      return 'invalid' unless valid?

      value = cron_expression.split[1]
      parse(value, 23)
    end

    def day_of_month_result
      return 'invalid' unless valid?

      value = cron_expression.split[2]
      parse(value, 31)
    end

    def month_result
      return 'invalid' unless valid?

      value = cron_expression.split[3]
      parse(value, 12)
    end

    def day_of_week_result
      return 'invalid' unless valid?

      value = cron_expression.split[4]
      parse(value, 7)
    end

    def command_result
      return 'invalid' unless valid?

      '/usr/bin/find'
    end

    private

    def format(title)
      title.ljust(14, ' ')
    end

    attr_accessor :cron_expression
  end
end