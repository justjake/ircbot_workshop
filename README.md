# IRC Bot Workshop 2013
with Jake Teton-Landis and Joseph Zemek,
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

## Steps.

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

### Basic IRC tasks

