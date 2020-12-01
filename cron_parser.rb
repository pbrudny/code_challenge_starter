require_relative 'lib/parse'

report = CronParser::Display.new(ARGV[0])
puts report.output