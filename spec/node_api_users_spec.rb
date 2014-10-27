require 'rspec'
require 'pacto/rspec'
require 'pacto/test_helper'
require 'byebug'

describe 'node api users contract' do
  include Pacto::TestHelper
  before do
    WebMock.allow_net_connect!
  end

  it 'validate contracts' do
    contracts = Pacto.load_contracts('node_api_contracts/chat.catch.la/v2/users', 'https://chat.catch.la:443')
    result = contracts.simulate_consumers
    result.entries.each do |entry|
      puts result unless entry.successful?
      expect(entry.citations).to be_empty
    end
  end
end
