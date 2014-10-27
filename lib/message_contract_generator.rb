require 'pacto'
require 'pacto/rspec'
require 'faraday'
require 'pry'

#   # Messages
#   'POST /messages': 'v2/Message.home'
#   'POST /messages/loaded': 'v2/Message.loaded'
#   'POST /v2/users/messages': 'v2/Message.find'
#   'POST /v2/messages/send_by_qiniu': 'v2/Message.incomming_qiniu'
#   'POST /v2/messages/notify_screenshot': 'v2/Message.notify_screenshot'
#   'POST /v2/messages/from_upyun': 'v2/Message.incomming_upyun'
class MessageContractGenerator
  include GeneratorHelper
  def get_messages
    response = send_request(:post, 'https://chat.catch.la', '/v2/users/messages')
  end
end
