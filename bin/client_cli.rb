# ruby bin/client_cli.rb -m search -q john -d true
require 'json'
require 'optparse'

require_relative '../lib/client_manager'


if ARGV.empty?
  puts 'Please provide a search query.'
  exit
end

options = {
  query: '',
  mode: 'search',
  people_group: 'client',
  field: 'full_name'
}

parser = OptionParser.new do |opts|
  opts.banner = "Usage: client_cli.rb [ -m mode | -q query ]"

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

  opts.on("-p", "--people_group GROUP", "where GROUP is either staff or client and would represent the pool of data to be used") do |people_group|
    options[:people_group] = people_group
  end

  opts.on("-f", "--field FIELD", "where FIELD ") do |field|
    options[:field] = field
  end
end

parser.parse!(ARGV)

file = options[:people_group] == 'client' ? 'lib/clients.json' : 'lib/staff.json'
data_source = JSON.parse(File.read(file))

ClientManager.new(data_source:, options:).run
