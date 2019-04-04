require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'nano_twitter'
require 'httparty'

# Uncomment this to run the tests on Heroku
NT_PATH = 'https://nano-twitter.herokuapp.com'

# Uncomment this if you're running everything locally
# NT_PATH = 'http://localhost:4567'

def assert_success(req)
  req.success?.must_equal true
end

describe 'NanoTwitter Gem' do

  before do
    handle = '@gem_tester'
    password = '@gem_tester'
    @name = 'Gem McTester'
    @client = NanoTwitter::Client.new(handle, password, NT_PATH)
    @client.register(@name)
  end

  Minitest.after_run { Thread.new {HTTParty.post("#{NT_PATH}/test/reset/all") } }

  describe 'NanoTwitter Gem After Registration' do
    it 'can log in as a user' do
      assert_success @client.login
    end

    it 'can post a tweet' do
      assert_success @client.tweet("Look Ma, I'm tweeting!")
    end

    describe 'Following' do

      before do
        @second_user = NanoTwitter::Client.new('@gem_test_followee', '@gem_test_followee', NT_PATH)
        @second_user.register 'Test Followee'
      end

      it 'can follow a user' do
        follow_resp = @client.follow('@gem_test_followee')
        json_resp = JSON.parse(follow_resp.parsed_response)
        json_resp['name'].must_equal '@gem_test_followee'
      end

      it 'can get followers' do
        @client.follow('@gem_test_followee')
        sleep(0.01)

        get_resp = @second_user.get_followers
        json_resp = JSON.parse(get_resp.parsed_response)
        json_resp.size.must_equal 1

        first_follower = json_resp.first
        first_follower['name'].must_equal 'Gem McTester'
        first_follower['handle'].must_equal '@gem_tester'
      end

      it 'can get followees' do
        @client.follow('@gem_test_followee')
        sleep(0.01)

        get_resp = @client.get_followees
        json_resp = JSON.parse(get_resp.parsed_response)
        json_resp.size.must_equal 1

        first_followee = json_resp.first
        first_followee['name'].must_equal 'Test Followee'
        first_followee['handle'].must_equal '@gem_test_followee'
      end

      it 'can get timeline' do
        @client.follow('@gem_test_followee')
        sleep(0.01)
        tweet_text = 'Hey followers!'
        @second_user.tweet tweet_text
        sleep(0.01)

        timeline_resp = @client.get_timeline
        json_resp = JSON.parse timeline_resp.parsed_response

        json_resp.size.must_equal 1

        json_resp.first['body'].must_equal tweet_text
      end
    end
  end
end
