require "nano_twitter/version"
require 'httparty'
require 'erb'

module NanoTwitter
  class Error < StandardError; end

  class Client
    attr_reader :name, :handle, :password, :api_path

    def initialize(handle, password, api_root)
      @handle = handle
      @password = password
      @api_path = "#{api_root}/api/#{NanoTwitter::VERSION}"
    end

    # Log into nanoTwitter
    def login
      HTTParty.post("#{@api_path}/login/#{@handle}/#{@password}")
    end

    # Register/create account
    def register(name)
      encoded_url = url_encode "#{name}/#{@handle}/#{@password}"
      HTTParty.post("#{@api_path}/signup/#{encoded_url}")
    end

    def url_encode(url)
      token_arr = url.split '/'
      encoded_arr = token_arr.map { |str| ERB::Util.url_encode str }
      encoded_arr.join '/'
    end

    # Post a new Tweet
    def tweet(tweet_body)
      encoded_url = url_encode "#{@handle}/#{@password}/#{tweet_body}"
      HTTParty.post("#{@api_path}/tweets/new/#{encoded_url}")
    end

    # Get list of Tweets in your timeline
    def get_timeline
      HTTParty.post("#{@api_path}/tweets/#{@handle}/#{@password}")
    end

    # Get list of users following you (creepy)
    def get_followers
      HTTParty.post("#{@api_path}/users/followers/#{@handle}/#{@password}")
    end

    # Get list of users you follow
    def get_followees
      HTTParty.post("#{@api_path}/users/followees/#{@handle}/#{@password}")
    end

    # Follow a new user
    def follow(followee_handle)
      HTTParty.post("#{@api_path}/users/follow/#{@handle}/#{@password}/#{followee_handle}")
    end
  end
end
