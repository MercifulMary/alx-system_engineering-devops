#!/usr/bin/env ruby

# Check if there is a command-line argument provided
if ARGV.empty?
  puts "Usage: #{$PROGRAM_NAME} <text>"
  exit 1
end

# Iterate through the command-line arguments
ARGV.each do |arg|
  # Use a regular expression to match the word "School" in the argument
  if arg.match(/School/)
    # Print the matched text
    puts arg
  end
end
