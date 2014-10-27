require 'rspec'
require 'pacto/rspec'
require 'pacto/test_helper'
require 'byebug'

describe 'node api attachment contract' do
  include Pacto::TestHelper
  before do
    WebMock.allow_net_connect!
  end

  it 'validate contracts' do
    contracts = Pacto.load_contracts('node_api_contracts/chat.catch.la/v2/attachments', 'https://chat.catch.la:443')
    #contracts.stub_providers
    result = contracts.simulate_consumers
    result.entries.each do |entry|
      puts result unless entry.successful?
      #expect(entry.successful?).to be_true
      expect(entry.citations).to be_empty
    end
  end
end
