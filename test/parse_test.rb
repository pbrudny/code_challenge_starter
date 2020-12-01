require_relative 'test_helper'
require_relative '../lib/parse'

describe CronParser::Parse do
  def parse(value, top)
    CronParser::Parse.new(value, top).call
  end

  describe 'all' do
    it { _(parse('*', 5)).must_equal('1 2 3 4 5') }
    it { _(parse('?', 5)).must_equal('1 2 3 4 5') }
    it { _(parse('**', 5)).must_equal('invalid cron expression') }
  end

  describe 'single number' do
    it { _(parse('1', 5)).must_equal('1') }
    it { _(parse('6', 5)).must_equal('invalid cron expression') }
    it { _(parse('-1', 5)).must_equal('invalid cron expression') }
  end

  describe 'comma separated numbers ' do
    it { _(parse('1,2', 5)).must_equal('1 2') }
    it { _(parse('1,5,10', 10)).must_equal('1 5 10') }
    it { _(parse('1,2,5,10,23', 23)).must_equal('1 2 5 10 23') }
    it { _(parse('1,5,10', 5)).must_equal('invalid cron expression') }
    it { _(parse('1,x,10', 5)).must_equal('invalid cron expression') }
  end

  describe 'skip numbers' do
    it { _(parse('*/1', 5)).must_equal('0 1 2 3 4 5') }
    it { _(parse('1/2', 5)).must_equal('1 3 5') }
    it { _(parse('3/5', 23)).must_equal('3 8 13 18 23') }
    it { _(parse('10/5', 23)).must_equal('10 15 20') }
    it { _(parse('10/5', 23)).must_equal('10 15 20') }
  end

  describe 'range' do
    it { _(parse('1-2', 5)).must_equal('1 2') }
    it { _(parse('1-5', 5)).must_equal('1 2 3 4 5') }
    it { _(parse('1-6', 5)).must_equal('invalid cron expression') }
    it { _(parse('1-1', 5)).must_equal('invalid cron expression') }
    it { _(parse('2-1', 5)).must_equal('invalid cron expression') }
  end
end
