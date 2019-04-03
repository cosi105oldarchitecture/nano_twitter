require 'net/http'
require 'uri'
require 'json'
require_relative './lib/nano_twitter'
include NanoTwitter

API_BASE = 'http://localhost:4567/api/0.5/login'
client = Client.new('@ahmed1000', '@ahmed1000')

uri = URI.parse(API_BASE)
header = { 'Content-Type': 'text/json' }
user = {
  handle: client.handle,
  password: client.password
}

# Create the HTTP objects
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new(uri.request_uri, header)
request.body = user.to_json

# Send the request
response = http.request(request)

puts request.body
