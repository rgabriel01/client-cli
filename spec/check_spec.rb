# rspec spec/check_spec.rb

require_relative '../lib/check'
require 'json'

RSpec.describe Check do
  describe '#call' do
    let!(:data_source) { JSON.parse(File.read('lib/clients.json')) }

    context 'when duplicate emails are found' do
      it 'returns an array of email addresses that have duplicates' do
        results = Check.call(data_source:)

        grouped_data_source = data_source.group_by {|data| data['email']}
        expected_results = grouped_data_source.keys.select do |email|
          grouped_data_source[email].size > 1
        end

        results.each do |result|
          expect(expected_results.include?(result['email'])).to be_truthy
        end
      end
    end

    context 'when duplicate are not found' do
      it 'returns an empty array' do
        raw = Check.call(data_source: [])

        expect(raw.size).to eq(0)
      end
    end
  end
end