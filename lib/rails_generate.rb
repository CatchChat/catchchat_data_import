require 'pacto'
require 'pacto/rspec'
require 'faraday'
require 'pry'

require_relative 'generator_helper'
require_relative 'auth_contract_generator'
#   # Friends
#   'POST /v2/users/friends': 'v2/Friend.list'
#   'POST /v2/users/add_friend': 'v2/Friend.add_friend'
#   'POST /v2/users/remove_friend': 'v2/Friend.remove'
#   'POST /v2/users/request_official_friend': 'v2/Friend.request_official_friend'
#   'POST /v2/users/request_official_media': 'v2/Friend.request_official_media'
#   'POST /v2/users/second_degree_friends': 'v2/Friend.second_degree_friends'
#   'POST /friends/find_by_phone': 'v2/Friend.find_by_phone'
#   'POST /v2/users/get_friend_requests': 'v2/Friend.list_friend_requests'
#   'POST /v2/users/delete_friend_requests': 'v2/Friend.drop_friend_requests'
#
#   'POST /v2/users/upload_phonebook': 'v2/Friend.upload_phonebook'
#
#   # Groups
#   'POST /v2/users/get_groups': 'v2/Group.get_groups'
#   'POST /v2/users/save_groups': 'v2/Group.modify_groups'
#
#   #Admin
#   'POST /admin/login': 'admin/Admin.login'
#   'GET /admin/user': 'admin/User.get_user'
#   'GET /admin/user/:target_id': 'admin/User.get_user_by_id'
#   'POST /admin/user/:target_id': 'admin/User.update_user'
#   'POST /admin/user/:target_id/password': 'admin/User.set_password'
#   'GET /admin/user/:target_id/messages': 'admin/Message.list_messages'
#   'PUT /admin/user/:target_id/block': 'admin/User.block_user'
#   'DELETE /admin/user/:target_id/block': 'admin/User.unblock_user'
#
#   'POST /admin/meta/:key': 'admin/Meta.set_by_key'
#   'GET /admin/meta/:key': 'admin/Meta.get_by_key'
#
#   'GET /admin/client/oldest_versions' : 'admin/Meta.get_oldest_versions'
#   'PUT /admin/client/oldest_versions' : 'admin/Meta.set_oldest_versions'
#
#   'GET /admin/feedback': 'admin/Feedback.range'
#   'GET /admin/feedback/:feedback_id': 'admin/Feedback.get_by_id'
#   'POST /admin/feedback/:feedback_id/reply': 'admin/Feedback.reply'
#
#   'GET /admin/live': 'admin/Live.find'
#   'GET /admin/live/:id': 'admin/Live.findOne'
#   'PUT /admin/live/:id': 'admin/Live.update'
#   'POST /admin/live': 'admin/Live.create'
#
#   'POST /admin/versions': 'admin/Client.create_version'
#   'PUT  /admin/versions/:id': 'admin/Client.update_version'
#   #Client
#   'GET /app/versions': 'Client.list_version'
#   'GET /app/versions/lastest': 'Client.find_version'
#   'GET /app/versions/:client_name/verify': 'Client.verify'
#   'GET /v2': 'Client.api_version'
#
#   #Feedback
#   'POST /v2/feedback': 'Feedback.give'
#   'POST /v2/feedback/mine': 'Feedback.mine'
#   'POST /v2/feedback/single': 'Feedback.single'
#
#   # Live
#   'GET  /live': 'live/Live.findOne'
#   'POST /live': 'live/Live.create'
#   'PUT  /live': 'live/Live.update'
#   'POST /live/broadcast': 'live/Broadcast.create'
#   'GET  /live/broadcast': 'live/Broadcast.find'
#   'GET  /live/broadcast/:id': 'live/Broadcast.findOne'
#   'PUT  /live/broadcast/:id': 'live/Broadcast.update'
# json_data = {username: "ruanwztest", password: "ruanwztest"}.to_json
# response = send_request(:post, 'https://chat.catch.la', '/v2/users/login_with_password', json_data)

# get messages

# create a new user

c = AuthContractGenerator.new contracts_path: 'rails_api_contracts'
c.token_by_login
c.token_by_mobile
c.send_verify_code
c.register_new_user
