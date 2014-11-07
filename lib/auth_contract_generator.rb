require 'pacto'
require 'pacto/rspec'
require 'faraday'
require 'pry'

require_relative 'generator_helper'

class AuthContractGenerator
  include GeneratorHelper

  def token_by_login
    username = 'ruanwztest'
    password = 'ruanwztest'
    expiring = 600
    json_data = {login: username, password: password, expiring: expiring}.to_json
    response = send_request(:post, 'http://localhost:3000', '/api/v4/auth/token_by_login', json_data)
  end

  def token_by_mobile
    username = '12345678'
    password = '12345'
    expiring = 500
    json_data = {login: username, password: password, expiring: expiring}.to_json
    response = send_request(:post, 'http://localhost:3000', '/api/v4/auth/token_by_mobile', json_data)
  end

  def send_verify_code
    username = '12345678'
    expiring = 500
    json_data = {login: username, expiring: expiring}.to_json
    response = send_request(:post, 'http://localhost:3000', '/api/v4/auth/send_verify_code', json_data)
  end
end
