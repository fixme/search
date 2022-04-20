# frozen_string_literal: true

require_relative '../lib/cache'
require_relative '../lib/storages/null_storage'
require_relative '../lib/storages/redis_storage'

Cache.storage = case ENV['APP_ENV']
                when 'production', 'preview'
                  RedisStorage.new(ENV['REDIS_URL'])
                else
                  NullStorage.new
                end
