# lib/search.rb
require 'byebug'
require 'JSON'

class Search
  attr_reader :query, :data_source, :debug_mode

  def self.call(query:, debug_mode:)
    if query.empty?
      puts 'Please provide a search query.'
      return
    end

    new(query: query, debug_mode: debug_mode).perform_search
  end

  def initialize(query:, debug_mode:)
    @data_source = JSON.parse(File.read('lib/clients.json'))
    @query = query
    @debug_mode = debug_mode
  end

  def perform_search
    results = search

    byebug
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