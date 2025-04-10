# rspec spec/client_manager_spec.rb
require_relative '../lib/client_manager'
require_relative '../lib/check'
require_relative '../lib/search'
require 'json'

RSpec.describe ClientManager do
  describe '#run' do
    let!(:data_source) { JSON.parse(File.read('lib/clients.json')) }

    context 'when mode is set to check' do
      it 'calls the Check class' do
        expect(Check).to receive(:call).with(data_source:).and_return([])
        ClientManager.new(data_source:, options: { mode: 'check' }).run
      end
    end

    context 'when mode is set to search' do
      it 'calls the Search class' do
        expect(Search).to receive(:call).with(data_source:, query: '').and_return([])
        ClientManager.new(data_source:, options: { mode: 'search', query: ''}).run
      end
    end

    context 'when mode is unknown' do
      it 'exits the execution and prints a message to the standard output' do
        expect{ClientManager.new(data_source:, options: { mode: 'welp', query: ''}).run}.to output('Invalid mode. Use --help for usage information.').to_stdout
      end
    end
  end
end