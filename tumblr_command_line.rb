#!/usr/bin/env ruby

require 'pry'
require 'tumblr_client'
require 'reverse_markdown'

class String
  def to_markdown
    ReverseMarkdown.parse(self)
  end
end

module EnhancedTumblr
  ###
  # DotHash
  # wraps a Ruby JSON-like datastructure (something made of only arrays, hashes,
  # and scalar datatypes) in a proxy that allows using thing.subscript instead of
  # thing["subscript"], just like in Javascript
  class DotHash
    def initialize(sub)
      @store = sub
    end

    def method_missing(method, *args, &blk)
      if @store.respond_to? method
        ret = @store.send(method, *args, &blk)
      else
        ret = @store[method.to_s]
      end

      if ret.is_a? Hash or ret.is_a? Array
        ret = DotHash.new ret
      end

      return ret
    end
  end

  def self.text_from_html(string)
    ReverseMarkdown.parse(string)
  end

  def self.client(opts)
    DotHash.new(Tumblr::Client.new(opts))
  end
end

client = EnhancedTumblr.client({
  :consumer_key =>        'REPLACE_ME',
  :consumer_secret =>     'REPLACE_ME',
  :oauth_token =>         'REPLACE_ME',
  :oauth_token_secret =>  'REPLACE_ME'
})

info = client.info
user = info.user
blog = user.blogs.find {|b| b["primary"] }
blog_name = blog.name

binding.pry
