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

  def upload_token_qiniu
    uri = Addressable::URI.new
    uri.query_values =  {
      bucket: 'ruanwz-public',
      key: 'thisisauuidkeyforfile'
    }
    # qiniu
    send_request(:get, 'http://localhost:3000', '/api/v4/attachments/upload_token/qiniu?'+uri.query)
  end

  def upload_token_upyun

    uri = Addressable::URI.new
    uri.query_values =  {
      bucket: 'ruanwz-public',
      file_path: '/thisisauuidkeyforfilewithrootpath',
      file_length: 222
    }
    send_request(:get, 'http://localhost:3000', '/api/v4/attachments/upload_token/upyun?'+ uri.query)
  end

  def upload_fields
    uri = Addressable::URI.new
    uri.query_values =  {
      bucket: 'ruanwz-public',
      key: 'thisisauuidkeyforfile'
    }
    send_request(:get, 'http://localhost:3000', '/api/v4/attachments/upload_fields/s3?'+uri.query)
  end

end
