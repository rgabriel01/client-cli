# lib/search.rb
#
require 'byebug'

class Search
  attr_reader :query, :data_source, :field

  def self.call(query:, data_source:, field:)
    new(query: query, data_source: data_source, field: field).perform_search
  end

  def initialize(query:, data_source:, field:)
    @data_source = data_source
    @query = query.downcase
    @field = field.downcase
  end

  def perform_search
    search
  end

  private

  def search
    case field
    when 'full_name'
      data_source.select do |client|
        client['full_name'].downcase.match?(query)
      end
    when 'rating'
      data_source.select do |client|
        client['rating'] >= query.to_f
      end
    else
      puts 'error unknown field'
      exit
    end
  end
end
