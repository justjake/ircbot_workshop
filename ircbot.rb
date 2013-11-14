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
BOT_TYPE = 'rudewatcher'
BOT_NICK =    ENV['USER'] + '-' + BOT_TYPE
BOT_CHANNELS = ['#ircbots']

# bot responds to '<Bot Name>: ', in channels, or commands at the start of the line, in PMs
# IRC bot commands must be prefixed by whatever Regex this returns
BOT_PREFIX = lambda do |m|
  if m.channel?
    /^#{Regexp.escape(m.bot.nick+":")}.*/
  else
    //
  end
end



# this class holds all our bot's actions.
class BotActions
  include Cinch::Plugin

  # LEVEL 2 TASK: respond to messages
  # - let people know when they are rude
  # - handle people saying "thank you" or otherwise responding
  #   to your bot after you let them know they were rude ;)

  # listen to all messages
  listen_to :message, method: :on_message

  # use_prefix: true indicates that we only match messages sent to our bot
  # which is to say prefixed with our bot's name:
  # 12:04 <@jitl>: josephz-rudewatcher: thank you for telling me I was rude.
  match /thank|shut up|wow|stop|annoy|job/, use_prefix: true, method: :on_reply

  EXCLAMATIONS = [
    'wow',
    'jeezy peets',
    'holy cow',
    'nhyomygawd',
    '(!)'
  ]

  RUDE_WORDS = [
    'poop',
    'butt',
    'moist',
    'fart',
    'miscreant',
    'ruffian',
    'harlot',
    'your mom',
  ]

  def on_message(message)
    # ignore bots of same type
    if message.user.nick.include? BOT_TYPE
      return
    end

    # accumulate the rude words we see in the message
    rude_words_used = []
    RUDE_WORDS.each do |word|
      if message.message.downcase.include? word
        rude_words_used.push(word)
      end
    end

    # send reply if any rude words were used
    if rude_words_used.length == 1
      message.reply("#{EXCLAMATIONS.sample} #{message.user}, you just used a pretty rude word")
    elsif rude_words_used.length > 1
      message.reply("#{EXCLAMATIONS.sample} #{message.user}, you just used #{rude_words_used.length} rude words.")
    end
  end

  def on_reply(message)
    puts "Message matched reply regexp: #{message.to_s}"
    message.reply("you're welcome ^_^")
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
