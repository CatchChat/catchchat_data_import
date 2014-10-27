module GeneratorHelper
  def initialize
    WebMock.allow_net_connect!

    Pacto.configure do |c|
      c.contracts_path = 'node_api_contracts'
    end

    Pacto.generate!
  end
  private
  def send_request(method, host, path, body=nil)
    username = 'ruanwztest'
    userid = '542a22ae4b44684f2ecb2398'
    token = '6c9fa5fcd90f86d56fa271a9b80f649e8e4c327097707cb12d7262ce93537d3d'
    password = 'ruanwztest'
    encoded_auth_password = Base64.encode64("#{username}:#{password}")
    encoded_auth_token = Base64.encode64("#{userid}:#{token}")
    conn = Faraday.new(:url => host) do |faraday|
      # faraday.request  :url_encoded             # form-encode POST params
      # faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    conn.send method, path do |req|
      req.headers['Content-Type'] = 'application/json'
      # req.headers['X-CatchChatToken'] = encoded_auth_token
      req.headers['X-CatchChatAuth'] = encoded_auth_password
      req.body = body if method == :post
    end
  end
end
