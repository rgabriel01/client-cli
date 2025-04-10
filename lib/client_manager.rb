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
      Check.call(debug_mode: @options[:debug_mode], data_source: data_source)
    when 'search'
      Search.call(query: options[:query], debug_mode: options[:debug_mode], data_source: data_source)
    else
      puts 'Invalid mode. Use --help for usage information.'
      exit
    end
  end
end