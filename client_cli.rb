require_relative 'lib/search'
require_relative 'lib/check'
require 'byebug'
require 'optparse'

data_source = JSON.parse(File.read('lib/clients.json'))

if ARGV.empty?
  puts 'Please provide a search query.'
  exit
end

options = {
  query: '',
  mode: 'search',
  debug_mode: false
}

parser = OptionParser.new do |opts|
  opts.banner = "Usage: client_cli.rb [ -m mode | -q query | -d debug ]"

  opts.on("-h", "--help", "Display the commands") do
    puts opts
    exit
  end

  opts.on("-m", "--mode MODE", "where MODE is either check or search for check detects duplicates in emails and search used to search for clients") do |mode|
    options[:mode] = mode.downcase
  end

  opts.on("-q", "--query QUERY", "where QUERY is any string to be used to match and search for client names") do |query|
    options[:query] = query
  end

  opts.on("-d", "--debug DEBUG", "where DEBUG is a boolean value that tells whether to print out logs or not") do |debug_mode|
    options[:debug_mode] = debug_mode.downcase == 'true' ? true : false
  end
end

parser.parse!(ARGV)

case options[:mode]
when 'check'
  Check.call(debug_mode: options[:debug_mode], data_source:)
when 'search'
  Search.call(query: options[:query], debug_mode: options[:debug_mode], data_source:)
else
  puts 'Invalid mode. Use --help for usage information.'
  exit
end