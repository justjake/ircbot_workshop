# IRC Bot Workshop (11/19 Tue 7:00-8:30PM 2013)
- with Jake Teton-Landis and Joseph Zemek,
  two programmers at Rescomp.

## Overview

By the end of this workshop, your IRC bot should be able to respond to a
variety of messages, perform scheduled actions, and communicate with an
external website API.

## Technologies

This workshop features the use of the following technologies:

- git,      to get this workshop framework.
- Ruby,     an easy scripting language that has a nice IRC bot framework
- web APIs. We're gonna show you how to get posts from your favorite
            tumblr feeds into IRC.

## Prerequisites

Minimal programming experience. Hopefully I'll provide enough framework
for everyone to get at least a basic IRC bot running, and enough extra
help along the way for to get even advanced features up and running for
the novince programmer.

## Workshop Plan

### Getting started with Git and Ruby

All the workshop notes and code are availible from a Git repo in my
homedir. To get the code, SSH into irc.housing.berkeley.edu and clone
this repo:

```shell
$ git clone ~jitl/ircbot_workshop
```
`cd` into the ircbot_workshop directory that Git creates and have a look
around. You'll see several files in this directory:

- README.md, which contains these notes

- Gemfile, a special file for Ruby projects that declares what "gems",
  or Ruby software packages, that the project requires. Just ignore this
  unless you want to run your IRC bot at home.

- bot.rb, which is our IRC bot code!

- environment.sh, a very simple shell file that will allow you to run
  ruby commands by adding my Ruby installation to your $PATH.
  (presenter note: explain $PATH if people are troubled)

Go ahead and load environment.sh into your terminal by typing
```shell
$ source ./environment.sh
```
You can now access `ruby`, the ruby evaluator, as well as `irb`, the
interactive Ruby interpreter, right in your console like you would
Python or any other scripting languate.

### Aside: Ruby on IRC.housing and PATH security
Ruby is not installed on irc.housing.berkeley.edu by default. I have
performed a manual installation in my home directory that all of you are
welcome to use. Please note however that the sysadmins do not support
this software. Please ask me if you have any troubles.

If you always add "/home/jitl/prefixes/rhel-headless/rbenv/shims:$PATH"
to your PATH, you are basically allowing me to replace executables like
`ls` or `screen` with my own versions. Be careful when you change PATH,
and make sure you inspect the directories in your PATH if something goes
wrong.

### Instant Ruby Overview
If you already know how to program in Python, ruby is pretty easy, as
its also a scripting language thats about easy development.

Python:

```python
# function
def add(a, b):
    return a + b

# class
class Person(object):
    def __init__(self, name):
        self.name = name

    def greet(self):
        return "Hello, " + self.name

# instantiation
me = Person("jake")
# method call
me.greet()
```

Ruby:

```ruby
# function (not lexically scoped, watch out)
def add(a, b)
    return a + b
end

# class
class Person
    # same as __init__ in python,
    # define `initialize` to perform new object setup.
    # note that explicit "self" parameter is not used
    def initialize(name)
        # @<varname> instead of self.<varname> to access
        # instance variables
        @name = name 
    end
    
    def greet()
        return "Hello, " + @name
    end
end

# instantiation
me = Person.new("Jake")
# method calls
me.greet()
```

Ruby does a ton of crazy crazy things that let you do some really cool
things, as we'll see once we start derping our IRC bots. But today ain't
about ruby. it's about bothering others on the internet. so let's get to
it!

### Level 1 Bot: we exist!

Pop open ircbot.rb in your favorite text editor to get started!
We're gonna connect our bots to IRC and see them show up in a channel.

(filling in config variables and running the bot for the first time)

`git checkout level1-{start,end}`

#### How IRC works

Today we'll be working with an IRC bot framework called Cinch.
Cinch does all the busy work of IRC for us. it:
  1. sets up a network connection to the IRC server
  2. logs in our bot and adds it to a list of channels
  3. runs loop where it sends commands to the IRC server,
     and dispatches events from the IRC server to our bot code



### Level 2 Bot: Hello User!

Now lets make our bots respond to IRC events. Specifically, we should
greet new users as they join a channel.

Methods:
    - onJoin

`git checkout level2-{start,end}`

### Level 3 Bot: Responding to messages

The meat and potatoes of an IRC bot. Here we learn how to use regular
expressions to listen for certain types of messages, and respond to
those messages.

Methods:
    - onRude, a default handler. Notifies someone if they use a rude
      word.
    - youreWelcome, a regex matcher that only responds if a "thank-you"
      message is sent to the bot. Sends back "You're welcome, peaceful
      friend"

`git checkout level3-{start,end}`

### Level 4 Bot: Tumblrbot

Connect IRC and Tumblr, everyone's two favorite things. We're going to
build a way to create and read tumblr posts from IRC! This includes
creating Tumblr API keys, setting up the messege listeners, etc

Methods:
    - post
    - read

`git checkout level4-{start,end}`
