require 'httparty'
require 'pry-byebug'
require_relative './lib/nano_twitter'
include NanoTwitter

API_BASE = 'http://localhost:4567/api/0.5/login'
# client = Client.new('brad', '@brad', '@brad')
client = Client.new('@ahmed1000', '@ahmed1000')

puts client.follow('@willow670')
# user = {
#   handle: client.handle,
#   password: client.password
# }

# response = HTTParty.post("#{API_BASE}/#{user[:handle]}/#{user[:password]}")
