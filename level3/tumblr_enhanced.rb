require 'tumblr_client'
require 'reverse_markdown'

class String
  def to_markdown
    ReverseMarkdown.parse(self)
  end
end

module TumblrEnhanced
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

  def self.client(opts)
    DotHash.new(Tumblr::Client.new(opts))
  end
end
