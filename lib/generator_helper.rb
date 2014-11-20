require "addressable/uri"
module GeneratorHelper
  def initialize(options)
    WebMock.allow_net_connect!

    Pacto.configure do |c|
      c.contracts_path = options.fetch :contracts_path
    end

    Pacto.generate!
  end
  private
  def send_request(method, host, path, body=nil)
    conn = Faraday.new(:url => host) do |faraday|
      # faraday.request  :url_encoded             # form-encode POST params
      # faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    conn.send method, path do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Accept-Language'] = 'en-US'
      # req.headers['X-CatchChatToken'] = encoded_auth_token
      # Below is only for node api
      # req.headers['X-CatchChatAuth'] = encoded_auth_password
      req.body = body if method == :post || method == :put
    end
  end
end
