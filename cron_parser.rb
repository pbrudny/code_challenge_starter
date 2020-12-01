require_relative 'lib/display'

report = CronParser::Display.new(ARGV[0])
puts report.output