# require "nano_twitter/version"
require 'httparty'

module NanoTwitter
  class Error < StandardError; end

  class Client
    attr_reader :name, :handle, :password, :api_path

    def initialize(handle, password)
      @name = name
      @handle = handle
      @password = password
      @api_path = 'http://localhost:4567/api/0.5'
    end

    # Log into nanoTwitter
    def login
      HTTParty.post("#{@api_path}/login/#{@handle}/#{@password}")
    end

    # Register/create account
    def register(name)
      HTTParty.post("#{@api_path}/signup/#{name}/#{@handle}/#{@password}")
    end

    # Post a new Tweet
    def tweet(tweet_body)
      tweet_body.gsub!(/\s/, '%20')
      HTTParty.post("#{@api_path}/tweets/new/#{@handle}/#{@password}/#{tweet_body}")
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
