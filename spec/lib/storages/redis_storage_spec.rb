# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RedisStorage do
  let(:storage) { described_class.new('redis://example.com:6380') }
  let(:redis) { instance_double('Redis') }
  let(:key) { instance_double('Key') }
  let(:value) { instance_double('Value') }

  before do
    allow(Redis).to receive(:new)
      .with(url: 'redis://example.com:6380')
      .and_return(redis)
  end

  describe '#read' do
    it 'gets value from redis' do
      expect(redis).to receive(:get).with(key).and_return(value)
      expect(storage.read(key)).to be value
    end
  end

  describe '#write' do
    let(:ttl) { instance_double('TTL') }

    it 'sets value in redis and sets TTL' do
      expect(redis).to receive(:set).with(key, value)
      expect(redis).to receive(:expire).with(key, ttl)
      storage.write(key, value, ttl: ttl)
    end
  end
end
