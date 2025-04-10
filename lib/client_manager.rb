require_relative 'search'
require_relative 'check'

class ClientManager
  attr_reader :data_source, :options

  def initialize(data_source:, options:)
    @data_source = data_source
    @options = options
  end

  def run
    case options[:mode]
    when 'check'
      results = Check.call(data_source: data_source)

      puts "Check results for duplicate email addresses:"
      results.each do |result|
        puts "==================="
        puts result.inspect
      end
    when 'search'
      results = Search.call(query: options[:query], data_source: data_source)

      puts "Search results for '#{options[:query]}':"
      results.each { |result| puts result }
    else
      puts 'Invalid mode. Use --help for usage information.'
      exit
    end
  end
end