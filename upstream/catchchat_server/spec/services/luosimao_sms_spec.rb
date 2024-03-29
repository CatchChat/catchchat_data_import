require 'rails_helper'
require 'timecop'
require 'vcr_helper'
require 'services_helper'
describe Sms do
  before do
    Timecop.freeze(Time.local(2014))
  end

  after do
    Timecop.return
  end

  context 'luosimao' do
    before do
      username         = ENV["luosimao_username"]
      apikey           = ENV["luosimao_apikey"]
      @init_hash       = {username: username, apikey: apikey}
      @luosimao_client = LuosimaoSms.new @init_hash
      @sms             = Sms.new(@luosimao_client, @init_hash)
    end

    subject {@sms}

    it "send sms message" do
      VCR.use_cassette('luosimao_send_sms') do
        code, body = @sms.send_sms mobile: '15626044835', message: 'Test Message'
        expect(code).to eq 200
        expect(body).to eq "{\"error\":0,\"msg\":\"ok\"}"

      end
    end
  end
end
