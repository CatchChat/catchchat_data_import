require 'rspec'
require 'pacto/rspec'
require 'pacto/test_helper'
require 'pry'
require 'byebug'

describe 'an example' do
  include Pacto::TestHelper
  before do
    WebMock.allow_net_connect!
  end

  it 'validate a contract' do
    contracts = Pacto.load_contracts('contracts/www.telize.com', 'http://www.telize.com:80')
    #contracts.stub_providers
    result = contracts.simulate_consumers
    result.entries.each do |entry|
      #expect(entry.successful?).to be_true
      expect(entry.citations).to be_empty
    end
  end
end
