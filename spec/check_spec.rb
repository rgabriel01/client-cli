# rspec spec/check_spec.rb

require_relative '../lib/check'
require 'json'

RSpec.describe Check do
  describe '#call' do
    let!(:data_source) { JSON.parse(File.read('lib/clients.json')) }

    context 'when debug_mode is true' do
      it 'outputs a message to stdout (puts)' do
        expect { Check.call(debug_mode: true, data_source:) }.to output(/Check results for duplicate email addresses:/).to_stdout
      end
    end

    context 'when duplicate emails are found' do
      it 'returns an array of email addresses that have duplicates' do
        raw = Check.call(debug_mode: false, data_source:)

        grouped_data_source = data_source.group_by {|data| data['email']}
        expected_results = grouped_data_source.keys.select do |email|
          grouped_data_source[email].size > 1
        end

        expect(raw.size).to eq(expected_results.size)
        raw.each do |email|
          expect(expected_results.include?(email)).to be_truthy
        end
      end
    end
  end
end