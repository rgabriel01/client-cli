# lib/search.rb

class Search
  attr_reader :query, :data_source

  def self.call(query:, data_source:)
    new(query: query, data_source: data_source).perform_search
  end

  def initialize(query:, data_source:)
    @data_source = data_source
    @query = query.downcase
  end

  def perform_search
    search
  end

  private

  def search
    data_source.select do |client|
      client['full_name'].downcase.match?(query)
    end
  end
end