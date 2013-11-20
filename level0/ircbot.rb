#!/usr/bin/env /home/jitl/prefixes/rhel-headless/rbenv/shims/ruby
###
# We'll be filling this file with a full IRC bot
# over the course of this workshop. For now its just an
# example ruby file
###
require 'pry' # interactive ruby console

module Example



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




  # ruby console with pry
  binding.pry
end
