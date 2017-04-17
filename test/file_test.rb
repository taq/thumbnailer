require 'test_helper'

describe ::Thumbnailer::File do
  before do
    clear_thumbs
    @file = ::Thumbnailer::File.new("#{Dir.pwd}/test/images/ruby-logo.png")
  end

  context 'base' do
    it 'must be kind of' do
      expect(::Thumbnailer::File.ancestors).must_include ::Thumbnailer::Base
    end
  end

  context 'size' do
    it 'must have the correct image size' do
      expect(@file.image_width).must_equal 514
      expect(@file.image_height).must_equal 512
    end

    it 'must have the correct thumb size' do
      expect(@file.width).must_equal 51
      expect(@file.height).must_equal 51
    end

    it 'must have a custom ratio size' do
      @file = ::Thumbnailer::File.new("#{Dir.pwd}/test/images/ruby-logo.png", ratio: 5)
      expect(@file.width).must_equal 102
      expect(@file.height).must_equal 102
    end

    it 'must have a custom size' do
      @file = ::Thumbnailer::File.new("#{Dir.pwd}/test/images/ruby-logo.png", width: 50, height: 45)
      expect(@file.width).must_equal  50
      expect(@file.height).must_equal 45
    end
  end

  context 'create' do
    it 'must create thumbnail' do
      @file.create
      expect(File.exist?(@file.output))
      image = MiniMagick::Image.open(@file.output)
      expect(image[:width]).must_equal 51
      expect(image[:height]).must_equal 51
    end

    it 'must create with custom prefix' do
      @file = ::Thumbnailer::File.new("#{Dir.pwd}/test/images/ruby-logo.png", prefix: 'custom_thumb_')
      expect(@file.output).must_match(/custom_thumb_ruby-logo.png$/)
    end

    it 'must create with custom dir' do
      @file = ::Thumbnailer::File.new("#{Dir.pwd}/test/images/ruby-logo.png", dir: '/tmp')
      expect(@file.output).must_equal '/tmp/thumb_ruby-logo.png'
      @file.create
      expect(File.exist?(@file.output))
    end
  end
end
