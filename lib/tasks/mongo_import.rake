require 'mongoid'
require_relative './mongo_models'
model_path = File.expand_path('../../../upstream/catchchat_server/app/models' , __FILE__)
Dir.glob(File.join(model_path, '*.rb')).each {|file| require file}
desc "import data from mongodb"
task :import_mongo => :environment do
  user         = MongoModels::User.first
  message      = MongoModels::Message.first
  friend_list  = MongoModels::FriendList.first
  verify_phone = MongoModels::VerifyPhone.first
end

