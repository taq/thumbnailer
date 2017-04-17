require 'test_helper'

describe ::Thumbnailer::Files do
  before do
    clear_thumbs
    @files = ::Thumbnailer::Files.new("#{Dir.pwd}/test/images/*.png")
  end

  context 'base' do
    it 'must be kind of' do
      expect(::Thumbnailer::Files.ancestors).must_include ::Thumbnailer::Base
    end
  end

  context 'collection' do
    it 'must respond to' do
      expect(@files).must_respond_to :collection
    end

    it 'must have a size' do
      expect(@files.size).must_equal 1
    end

    it 'must create thumbs' do
      @files.create
      expect(File.exist?("#{Dir.pwd}/test/images/thumb_ruby-logo.png")).must_equal true
    end

    it 'must create thumbs with custom prefix' do
      @files = ::Thumbnailer::Files.new("#{Dir.pwd}/test/images/*.png", prefix: 'custom_thumb_')
      @files.create
      expect(File.exist?("#{Dir.pwd}/test/images/custom_thumb_ruby-logo.png")).must_equal true
    end

    it 'must create thumbs with custom dir' do
      @files = ::Thumbnailer::Files.new("#{Dir.pwd}/test/images/*.png", dir: '/tmp')
      @files.create
      expect(File.exist?("/tmp/thumb_ruby-logo.png")).must_equal true
    end
  end
end
