#!/usr/bin/env /home/jitl/prefixes/rhel-headless/rbenv/shims/ruby

# setup required for rubygems/bundler to work
require 'rubygems'
require 'bundler/setup'

# interactive ruby console, useful for debugging.
# invoke anywhere by calling `binding.pry`
require 'pry'

# the IRC bot library
require 'cinch'

# some global constants - plz don't remove the ENV['USER'] part
# during this workshop. It's good to know who is who.
BOT_NICK =    ENV['USER'] + '-helloworld'
BOT_CHANNELS = ['#ircbots']


# this class holds all our bot's actions.
class BotActions
  include Cinch::Plugin

  # LEVEL 1 TASK: make your bot greet users when they enter the 
  # channel, and say goodbye when they leave.

  # hook up events to your methods here
  listen_to :join, method: :on_join

  def on_join(message)
    # you can see this debug message in your bot window
    # .to_s is like str() in python
    puts "DEBUG: someone joined " + message.to_s
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
    c.plugins.plugins = [BotActions]
  end
end

# connect to the IRC server!
bot.start
