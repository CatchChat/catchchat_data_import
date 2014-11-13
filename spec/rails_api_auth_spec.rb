require 'rspec'
require 'pacto/rspec'
require 'pacto/test_helper'
require 'byebug'

describe 'rails api auth contract' do
  include Pacto::TestHelper
  before do
    WebMock.allow_net_connect!
  end

  it 'validate auth contracts' do
    contracts = Pacto.load_contracts('rails_api_contracts/localhost/api/v4/auth', 'http://localhost:3000')
    result = contracts.simulate_consumers
    result.entries.each do |entry|
      puts result unless entry.successful?
      expect(entry.citations).to be_empty
    end
  end
end
