#!/usr/bin/env /home/jitl/prefixes/rhel-headless/rbenv/shims/ruby
# setup required for rubygems/bundler to work
require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'cinch'
# tumblr support -- with a few extra goodies from Jake
require_relative "tumblr_enhanced"

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
Client = TumblrEnhanced.client({
  :consumer_key =>       'REPLACE_ME',
  :consumer_secret =>    'REPLACE_ME',
  :oauth_token =>        'REPLACE_ME',
  :oauth_token_secret => 'REPLACE_ME'
})

# make sure the client works
puts "Testing tumblr connection..."
if Client.info.user.nil?
  puts "Tumblr connection failed: #{client_info}"
  puts "Check your OAuth parameters"
  exit 1
end



# this class holds all our bot's actions.
class BotActions
  include Cinch::Plugin
  def initialize(bot)
    @blog = Client.info.user.blogs.find {|b| b["primary"] }
    @last_check = Time.now
    super(bot)
  end



  ### Level 3: Tumblrbot
  # display new posts from your tumblr from IRC
  timer 60, method: :check_new_posts
  def check_new_posts()
    puts "checking for posts since #{@last_check}"
    
    
    # YOUR CODE HERE
    
    
    @last_check = Time.now
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
