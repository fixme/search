# frozen_string_literal: true

require 'redis'

# Cache wrapper for Redis
class RedisStorage
  def initialize(url)
    @redis = Redis.new(url: url)
  end

  def write(key, value, ttl:)
    @redis.set(key, value)
    @redis.expire(key, ttl)
  end

  def read(key)
    @redis.get(key)
  end
end
