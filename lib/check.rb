# lib/check.rb
require 'byebug'
class Check
  attr_reader :data_source, :grouped_data_source

  def self.call(data_source:)
    new(data_source: data_source).perform_check
  end

  def initialize(data_source:)
    @grouped_data_source = data_source.group_by {|data| data['email']}
  end

  def perform_check
    check
  end

  private

  def check
    with_duplicates = grouped_data_source.keys.select do |email|
      grouped_data_source[email].size > 1
    end

    with_duplicates.map do |email|
      grouped_data_source[email]
    end
  end
end