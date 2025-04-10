# lib/check.rb
require 'JSON'

class Check
  attr_reader :data_source, :grouped_data_source, :debug_mode

  def self.call(debug_mode:, data_source:)
    new(debug_mode: debug_mode, data_source: data_source).perform_check
  end

  def initialize(debug_mode:, data_source:)
    @grouped_data_source = data_source.group_by {|data| data['email']}
    @debug_mode = debug_mode
  end

  def perform_check
    results = check

    display_results(results) if debug_mode

    results
  end

  private

  def check
    results = grouped_data_source.keys.select do |email|
      grouped_data_source[email].size > 1
    end

    results
  end

  def display_results(results)
    puts "Check results for duplicate email addresses:"
    results.each do |result|
      puts "==================="
      puts result.inspect
      puts grouped_data_source[result].inspect
    end
  end
end