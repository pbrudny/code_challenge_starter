require 'pry'
require_relative '../lib/validator'

module CronParser
  class Parse
    def initialize(value, top)
      self.value = value
      self.top = top
    end

    def call
      return all_values(top) if value == '*' || value == '?'
      return skip_values(value, top) if skip_numbers?(value, top)
      return value if numeric?(value) && value.to_i < top && value.to_i >= 0
      return numeric_values(value) if numeric_with_commas?(value, top)
      return range_values(value) if range?(value, top)
      'invalid cron expression'
    end

    def all_values(top)
      (1..top).to_a.join(' ')
    end

    def range_values(range)
      numbers = range.split('-')
      (numbers[0].to_i..numbers[1].to_i).to_a.join(' ')
    end

    def skip_numbers?(value, top)
      args = value.split('/')
      args.count == 2 &&
        (args[0] == '*' || numeric?(args[0]) && args[0].to_i < top) &&
        numeric?(args[1]) && args[1].to_i < top
    end

    def numeric_with_commas?(value, top)
      numbers = value.split(',')
      numbers.count > 1 && numbers.all? { |n| numeric?(n) && n.to_i <= top }
    end

    def numeric_values(value)
      value.split(',').join(' ')
    end

    def skip_values(value, top)
      args = value.split('/')
      i = args[0] == '*' ? 0 : args[0].to_i

      result = []
      while i <= top
        result << i
        i += args[1].to_i
      end
      result.join(' ')
    end

    def range?(value, top)
      numbers = value.split('-')
      numbers.count == 2 &&
        numeric?(numbers[0]) &&
        numeric?(numbers[1]) &&
        numbers[0].to_i < numbers[1].to_i &&
        numbers[1].to_i <= top
    end

    def numeric?(value)
      true if Float(value) rescue false
    end

    private

    def format(title)
      title.ljust(14, ' ')
    end

    attr_accessor :value, :top
  end
end