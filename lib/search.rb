# lib/search.rb

class Search
  attr_reader :query, :data_source, :debug_mode

  def self.call(query:, debug_mode:, data_source:)
    new(query: query, debug_mode: debug_mode, data_source: data_source).perform_search
  end

  def initialize(query:, debug_mode:, data_source:)
    @data_source = data_source
    @query = query.downcase
    @debug_mode = debug_mode
  end

  def perform_search
    results = search

    display_results(results) if debug_mode

    results
  end

  private

  def search
    data_source.select do |client|
      client['full_name'].downcase.match?(query)
    end
  end

  def display_results(results)
    puts "Search results for '#{query}':"
    results.each { |result| puts result }
  end
end