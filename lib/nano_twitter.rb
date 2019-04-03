# require "nano_twitter/version"
require 'net/http'
require 'uri'
require 'json'

module NanoTwitter
  class Error < StandardError; end

  class Client
    attr_reader :user_handle, :password, :api_path

    def initialize(user_handle, password)
      @user_handle = user_handle
      @password = password
      @api_path = 'https://nano-twitter-staging.herokuapp.com/api/0.5/'
    end
  end
end
