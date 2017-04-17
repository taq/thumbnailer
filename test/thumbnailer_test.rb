require 'test_helper'

describe Thumbnailer do
  context 'version' do
    it 'has one' do
      refute_nil ::Thumbnailer::VERSION
    end
  end
end
