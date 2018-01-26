# require 'command_line_reporter'
#
# class Example
#   include CommandLineReporter
#
#   def initialize
#     self.formatter = 'progress'
#   end
#
#   def run(num)
#     report do
#       sum = 0
#       num.times do
#         sum += 1
#         sleep 0.1
#         progress
#       end
#       vertical_spacing
#       aligned("Sum: #{sum}")
#     end
#   end
#
# end
