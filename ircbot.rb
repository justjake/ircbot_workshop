#!/usr/bin/env /home/jitl/prefixes/rhel-headless/rbenv/shims/ruby
# setup required for rubygems/bundler to work
require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'cinch'
# tumblr support
require 'tumblr_client'

# some global constants - plz don't remove the ENV['USER'] part
# during this workshop. It's good to know who is who.
BOT_TYPE = 'tumblr'
BOT_NICK =    ENV['USER'] + '-' + BOT_TYPE
BOT_CHANNELS = ['#ircbots']


# Changed from Level 2.
# bot responds to '<Bot Name>: ', in channels, or commands at the start of the line, in PMs
# IRC bot commands must be prefixed by whatever Regex this returns
BOT_PREFIX = lambda do |m|
  if m.channel?
    /^#{Regexp.escape(m.bot.nick+":")} /
  else
    //
  end
end



### Level 3: Tumblrbot
# tumblr configuration
# consumer_key and comsumer_secret:   http://www.tumblr.com/oauth/apps
# oauth_token and oauth_token_secret: https://api.tumblr.com/console//calls/user/info
client = Tumblr::Client.new({
  :consumer_key =>        'REPLACE_ME',
  :consumer_secret =>     'REPLACE_ME',
  :oauth_token =>         'REPLACE_ME',
  :oauth_token_secret =>  'REPLACE_ME'
})

# make sure the client works
puts "Testing tumblr connection..."
client_info = client.info
if client_info["status"] != 200
  puts "Tumblr connection failed: #{client_info["msg"]}"
  exit 1
end



# this class holds all our bot's actions.
class BotActions
  include Cinch::Plugin
  def initialize(bot)
    # only show new tumblr posts since the `@last_fetch_timestamp`
    @last_fetch_timestamp = Time.new
    super(bot)
  end



  ### Level 3: Tumblrbot
  match /REPLACE_ME/, method: :get_updates
  # you need to match two groups: one for post_name, one for post_body
  match /REPLACE_ME/, method: :create_post

  # display new posts from your tumblr from iRC
  def get_updates(message)
    puts "get_updates since #{@last_fetch_timestamp}"
    @last_fetch_timestamp = Time.new

    # YOUR CODE HERE
  end

  # publish a new post on your Tumblog
  def create_post(message, post_name, post_body)
    puts "create_post name: '#{post_name}' body: '#{post_body}'"

    # YOUR CODE HERE
  end

end




# the bot object handles connecting to the IRC server
# It uses our BotActions class to define its behavior once
# its connected and all set up
#
# you can pretty much ignore this part -- you won't have to 
# touch it to get your actions to work.
bot = Cinch::Bot.new do 
  configure do |c|
    c.nick = BOT_NICK
    c.server = 'localhost'
    c.channels = BOT_CHANNELS
    c.verbose = true
    c.plugins.prefix = BOT_PREFIX
    c.plugins.plugins = [BotActions]
  end
end

# connect to the IRC server!
bot.start
