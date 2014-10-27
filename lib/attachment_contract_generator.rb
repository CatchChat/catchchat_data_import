require 'pacto'
require 'pacto/rspec'
require 'faraday'
require 'pry'

#  'POST /v2/attachments/avatar_token': 'v2/Attachment.avatar_token'
#  'POST /v2/attachments/get_avatar_url': 'v2/Attachment.get_avatar_url'
#  'POST /v2/attachments/get_url': 'v2/Attachment.get_url'
#   'POST /v2/attachments/token': 'v2/Attachment.token'
# #  'POST /v2/attachments/token_callback': 'v2/Attachment.token_callback'
#   'POST /v2/attachments/token_callback': 'v2/Attachment.qiniu_token'
#   'POST /v2/attachments/upyun_token': 'v2/Attachment.upyun_token'
#
class AttachmentContractGenerator
  include GeneratorHelper


  def get_avatar_url
    # POST /attachments/get_avatar_url
    json_data = {
      key: 'ruanwztest2',
    }.to_json
    response = send_request(:post, 'https://chat.catch.la', '/v2/attachments/get_avatar_url', json_data)
  end

  def get_avatar_token
    # POST /attachments/avatar_token
    json_data = {
      key: 'ruanwztest2',
    }.to_json
    response = send_request(:post, 'https://chat.catch.la', '/v2/attachments/avatar_token', json_data)
  end

  #'POST /v2/attachments/get_url': 'v2/Attachment.get_url'
  def get_url
    json_data = {
      key: 'ruanwztest2',
    }.to_json
    response = send_request(:post, 'https://chat.catch.la', '/v2/attachments/get_url', json_data)
  end

  def token
    json_data = {
      key: 'ruanwztest2',
    }.to_json
    response = send_request(:post, 'https://chat.catch.la', '/v2/attachments/token', json_data)
  end

  def qiniu_token
    json_data = {
      callbackBody: 'test body',
      filename: 'test.jpg'

    }.to_json
    response = send_request(:post, 'https://chat.catch.la', '/v2/attachments/token_callback', json_data)
  end

end
