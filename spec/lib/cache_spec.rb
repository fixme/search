# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Cache do
  let(:cache) { described_class }

  describe 'fetch' do
    let(:storage) { instance_double('Storage') }
    let(:key) { instance_double('Key') }

    before do
      allow(cache.instance).to receive(:storage).and_return(storage)
      allow(storage).to receive(:read).with(key).and_return(cached_value)
      allow(storage).to receive(:write)
    end

    context 'when storage has the key' do
      let(:value) { instance_double('Value') }
      let(:cached_value) { instance_double('CachedValue') }

      it 'uses cached value' do
        result = cache.fetch(key, ttl: 10) do
          value
        end
        expect(result).to be cached_value
      end

      it 'does not run the block if provided' do
        expect do |block|
          cache.fetch(key, ttl: 10, &block)
        end.not_to yield_with_no_args
      end
    end

    context 'when storage does not have the key' do
      let(:value) { instance_double('Value') }
      let(:cached_value) { nil }

      it 'returns value from the block' do
        result = cache.fetch(key, ttl: 10) do
          value
        end
        expect(result).to be value
      end

      it 'does run the block' do
        expect do |block|
          cache.fetch(key, ttl: 10, &block)
        end.to yield_with_no_args
      end

      it 'writes values to storage' do
        expect(storage).to receive(:write).with(key, value, ttl: 10)
        cache.fetch(key, ttl: 10) do
          value
        end
      end
    end
  end
end
