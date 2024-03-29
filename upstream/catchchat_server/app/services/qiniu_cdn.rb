require 'qiniu'
require 'vanguard'
require 'virtus'

class QiniuCdn
  include Virtus
  attribute :access_key, String
  attribute :secret_key, String
  attribute :bucket, String
  attribute :key, String
  attribute :url, String
  attribute :expires_in, String
  attribute :callback_url, String
  attribute :callback_body, String
  attribute :file_location, String
  def initialize(keys)
    super
    Qiniu.establish_connection! access_key: access_key,
                                secret_key: secret_key
  end

  def prepare(cdn)
    self.attributes = self.attributes.merge cdn.options
  end

  def get_upload_token(args = {})
    self.attributes = self.attributes.merge args
    fail unless UPLOADVALIDATOR.call(self).valid?

    put_policy.callback_url = callback_url
    Qiniu::Auth.generate_uptoken(put_policy)
  end


  def get_download_url(args)
    self.attributes = self.attributes.merge args
    fail unless DOWNLOADVALIDATOR.call(self).valid?
    Qiniu::Auth.authorize_download_url(url)
  end

  def upload_file(args)
    self.attributes = self.attributes.merge args

    code, _result, _response_headers = Qiniu::Storage.upload_with_put_policy(
      put_policy, file_location, 'test-key')
    code
  end

  DOWNLOADVALIDATOR = Vanguard::Validator.build do
      validates_presence_of :url
  end

  UPLOADVALIDATOR = Vanguard::Validator.build do
      validates_presence_of :callback_url, :callback_body
  end

  private
  def put_policy
    @put_policy ||= Qiniu::Auth::PutPolicy.new(
            bucket,     # 存储空间
            key,        # 最终资源名，可省略，即缺省为“创建”语义
            expires_in || 3600 # 相对有效期，可省略，缺省为3600秒后 uptoken 过期
        )
    @put_policy.callback_url  = callback_url
    @put_policy.callback_body = callback_body
    @put_policy
  end
end
