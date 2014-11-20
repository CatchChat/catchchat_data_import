require 'rspec'
require 'pacto/rspec'
require 'pacto/test_helper'
require 'byebug'
require 'pry'

describe 'rails api attachments contract' do
  include Pacto::TestHelper
  before do
    WebMock.allow_net_connect!
  end

  it 'validate attachments contracts' do
    contracts = Pacto.load_contracts('rails_api_contracts/localhost/api/v4/attachments', 'http://localhost:3000')
    result = contracts.simulate_consumers
    result.entries.each do |entry|
      puts result unless entry.successful?
      expect(entry.citations).to be_empty
    end
  end
end
