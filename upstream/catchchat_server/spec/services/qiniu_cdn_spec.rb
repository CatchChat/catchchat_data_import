require 'rails_helper'
require 'timecop'
require 'vcr_helper'
require 'services_helper'
describe Cdn do
  before do
    Timecop.freeze(Time.local(2014))
  end

  after do
    Timecop.return
  end

  context 'qiniu' do
    before do
      access_key    = ENV["qiniu_access_key"]
      secret_key    = ENV["qiniu_secret_key"]

      @client_init_hash    = {client_init: 'test', access_key: access_key, secret_key: secret_key}
      @cdn_init_hash    = {cdn_init: 'test', access_key: access_key, secret_key: secret_key}
      @qiniu_client = QiniuCdn.new @client_init_hash
      @cdn          = Cdn.new(@qiniu_client, @cdn_init_hash)
    end

    subject {@cdn}

    it "fail if validation not pass" do
      expect {
        subject.get_upload_token bucket: 'ruanwz-public'
      }.to raise_error
    end

    it "provide upload token for qiniu" do
      qiniu_upload_token = subject.get_upload_token bucket: 'ruanwz-public',
                                                       test: 'abc',
                                                       key: 'test-key',
                                              callback_url: 'http://catchchat-callback.herokuapp.com/hi',
                                              callback_body: "name=fname&hash=myhash"
      expect(qiniu_upload_token).to eq "BBHE3ccYQ8VQhEIvZbJARrte1U3ic2Om6CW7mxvN:cSkUKZglWsifwHuII-_gM2cD-EI=:eyJzY29wZSI6InJ1YW53ei1wdWJsaWM6dGVzdC1rZXkiLCJjYWxsYmFja1VybCI6Imh0dHA6Ly9jYXRjaGNoYXQtY2FsbGJhY2suaGVyb2t1YXBwLmNvbS9oaSIsImNhbGxiYWNrQm9keSI6Im5hbWU9Zm5hbWVcdTAwMjZoYXNoPW15aGFzaCIsImRlYWRsaW5lIjoxMzg4NTA5MjAwfQ=="
    end

    it "provide download url for qiniu" do
      qiniu_download_url = subject.get_download_url url: "http://hello.qiniu.com/a/b/c.jpg"
      expect(qiniu_download_url).to eq "http://hello.qiniu.com/a/b/c.jpg?e=1388509200&token=BBHE3ccYQ8VQhEIvZbJARrte1U3ic2Om6CW7mxvN:Ff38tdgiw8yFLjzLHrKzwABSogc="
    end

    it "upload file for qiniu" do
      Timecop.return

      t = Tempfile.new 'abc'
      VCR.use_cassette('qiniu_upload_file') do
        code = subject.upload_file file_location: t.path,
                                          bucket: 'ruanwz-public',
                                             key: 'test-key',
                                    callback_url: 'http://catchchat-callback.herokuapp.com/hi',
                                    callback_body: "name=fname&hash=myhash"

        expect(code).to eq 200
      end

    end
  end

end
