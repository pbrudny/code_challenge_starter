require 'pry'

module CronParser
  class Validator
    def initialize(cron_expression)
      self.cron_expression = cron_expression
      self.args = cron_expression.split
      self.minute = args[0]
      self.hour = args[1]
      self.day_of_month = args[2]
      self.month = args[3]
      self.day_of_week = args[4]
    end

    def call
      return false unless cron_expression.length >= 11
      return false unless args.count >= 6
      return false unless regex_ok?
      return false if both_week_month_day?

      true
    end

    def regex_ok?
      minute_match(minute) &&
        hour_match(hour) &&
        day_of_month_match(day_of_month) &&
        month_match(month) &&
        day_of_week_match(day_of_week)
    end

    def both_week_month_day?
      day_of_month == '*' && day_of_week == '*'
    end

    def minute_match(value)
      value.match(/^[0-9,\-*\/]+$/)
    end

    def hour_match(value)
      value.match(/^[0-9,\-*\/]+$/)
    end

    def day_of_month_match(value)
      value.match(/^[0-9,\-*\/?LW]+$/)
    end

    def month_match(value)
      value.match(/^[0-9,\-*\/]+$/)
    end

    def day_of_week_match(value)
      value.match(/^[0-9,\-*\/L#?]+$/)
    end

    private

    attr_accessor :cron_expression, :args, :minute,
                  :hour, :day_of_month, :month, :day_of_week
  end
end
