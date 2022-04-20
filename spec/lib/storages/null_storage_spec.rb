# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NullStorage do
  let(:storage) { described_class.new }
  let(:key) { instance_double('Key') }

  describe '#read' do
    it 'does not raise an error' do
      expect do
        storage.read(key)
      end.not_to raise_error
    end
  end

  describe '#write' do
    let(:value) { instance_double('Key') }
    let(:ttl) { instance_double('Key') }

    it 'does not raise an error' do
      expect do
        storage.write(key, value, ttl: ttl)
      end.not_to raise_error
    end
  end
end
