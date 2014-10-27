require 'pacto'
require 'pacto/rspec'
require 'faraday'
require 'pry'

#   # Passport
#   'POST /v2/users/login_with_password': 'v2/Passport.login_with_password'
#   'POST /v2/users/reset_token': 'v2/Passport.reset_token'
#   'POST /v2/users/login': 'v2/Passport.ancient_login'
#   # Users
#   'GET  /v2/users': 'v2/User.findone'
#   'POST /v2/users/batch_query': 'v2/User.find'
#   'POST /v2/users': 'v2/User.create'
#   'POST /v2/users/update': 'v2/User.update'
#   'POST /v2/users/destroy': 'v2/User.destroy'
#   'POST /v2/users/send_verify': 'v2/User.send_verify'
#   'POST /v2/users/search_by_username': 'v2/User.search_by_username'
#   'POST /v2/users/add_device_token': 'v2/User.add_iphone_token'
#   'POST /v2/users/android_push': 'v2/User.add_android_token'
#   'POST /v2/users/verify_phone': 'v2/User.verify_phone'
#   'POST /v2/users/update_client_mode': 'v2/User.update_client_mode'
#   'POST /v2/users/send_security_code': 'v2/User.send_security_code'
#   'POST /v2/users/reset_password': 'v2/User.reset_password'
#   'POST /v2/users/search_by_keyword': 'v2/User.search_by_keyword'
#   'GET  /v2/users/check': 'v2/User.check'
require_relative 'generator_helper'
class UserContractGenerator
  include GeneratorHelper

  def login
    username = 'ruanwztest'
    password = 'ruanwztest'
    json_data = {username: username, password: password}.to_json
    response = send_request(:post, 'https://chat.catch.la', '/v2/users/login_with_password', json_data)
  end

  def create_user
    # property | is required | description
    # -------- | -------- | -----------
    # username | required |
    # password | required |
    # nickname | optional |
    # avatar   | optional |
    json_data = {
      username: 'ruanwztest3',
      password: 'ruanwztest3',
      nickname: 'ruanwztest3nickname'
    }.to_json
    response = send_request(:post, 'https://chat.catch.la', '/v2/users', json_data)
  end

  def check_user
    json_data = {
      username: 'ruanwztest2',
      password: 'ruanwztest2',
    }.to_json
    response = send_request(:get, 'https://chat.catch.la', '/v2/users/check')
  end

  def user_find_one
    json_data = {
      user_id: 'ruanwztest'
    }.to_json
    response = send_request(:get, 'https://chat.catch.la', '/v2/users?user_id=ruanwz')
  end
  #   'POST /v2/users/batch_query': 'v2/User.find'
  def user_batch_query
    json_data = {
      users: ['542919dd26beba301a227534']
    }.to_json
    response = send_request(:post, 'https://chat.catch.la', '/v2/users/batch_query', json_data)

  end

  #   'POST /v2/users/update': 'v2/User.update'
  def update_user
    json_data = {
      users: ['542919dd26beba301a227534']
    }.to_json
    response = send_request(:post, 'https://chat.catch.la', '/v2/users/batch_query', json_data)
  end

end

