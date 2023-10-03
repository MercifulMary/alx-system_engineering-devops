#!/usr/bin/env ruby

# Check if a log file path is provided as an argument
if ARGV.empty?
  puts "Usage: #{$PROGRAM_NAME} <log_file>"
  exit 1
end

# Read the log file specified in the argument
log_file_path = ARGV[0]

# Define a regex pattern to match the required information
pattern = /\[from:(.*?)\] \[to:(.*?)\] \[flags:(.*?)\]/

# Read the log file line by line and extract the required information
File.foreach(log_file_path) do |line|
  match_data = line.match(pattern)
  if match_data
    sender = match_data[1]
    receiver = match_data[2]
    flags = match_data[3]
    
    # Display the extracted information in the required format
    puts "#{sender},#{receiver},#{flags}"
  end
end
