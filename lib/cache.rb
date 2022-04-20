# frozen_string_literal: true

require 'singleton'

# Caching used for external requests
class Cache
  include Singleton

  attr_accessor :storage

  def fetch(key, ttl:)
    cached = storage.read(key)
    value = cached || yield
    storage.write(key, value, ttl: ttl) unless cached
    value
  end

  def self.method_missing(method, *args, **named_args, &block)
    if instance.respond_to?(method)
      instance.send(method, *args, **named_args, &block)
    else
      super
    end
  end

  def self.respond_to_missing?(method, include_private = false)
    instance.respond_to?(method) || super
  end
end
