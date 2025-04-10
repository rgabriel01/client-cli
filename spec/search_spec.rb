# rspec spec/search_spec.rb

require_relative '../lib/search'
require 'json'

RSpec.describe Search do
  describe '#call' do
    let!(:data_source) { JSON.parse(File.read('lib/clients.json')) }

    context 'when the passed query matches a record' do
      it 'returns an array of client hash with partial matches on the full_name segment' do
        raw = Search.call(query: 'john', data_source:)

        expected_results = data_source.select do |client|
          client['full_name'].downcase.match?('john')
        end

        expect(raw.size).to eq(expected_results.size)
        raw.each do |client|
          expect(expected_results.find {|result| result['id'] == client['id']}.any?).to be_truthy
        end
      end
    end

    context 'when the passed query is with varying letter cases' do
      it 'returns an array of client hash with partial matches on the full_name segment' do
        raw = Search.call(query: 'JOhn', data_source:)

        expected_results = data_source.select do |client|
          client['full_name'].downcase.match?('john')
        end

        expect(raw.size).to eq(expected_results.size)
        raw.each do |client|
          expect(expected_results.find {|result| result['id'] == client['id']}.any?).to be_truthy
        end
      end
    end

    context 'when the passed query does not match any record' do
      it 'returns an empty array' do
        raw = Search.call(query: 'qwerty', data_source:)

        expect(raw.size).to eq(0)
      end
    end
  end
end