require 'test_helper'

describe ::Thumbnailer::PDF do
  before do
    clear_thumbs
    @pdf = ::Thumbnailer::PDF.new("#{Dir.pwd}/test/pdfs/test.pdf", format: 'png')
  end

  context 'base' do
    it 'must be kind of' do
      expect(::Thumbnailer::Files.ancestors).must_include ::Thumbnailer::Base
    end
  end

  context 'collection' do
    it 'must respond to' do
      expect(@pdf).must_respond_to :collection
    end

    it 'must have a size' do
      expect(@pdf.size).must_equal 2
    end

    it 'must create thumbs' do
      @pdf.create
      expect(File.exist?("#{Dir.pwd}/test/pdfs/thumb_test_1.png")).must_equal true
      expect(File.exist?("#{Dir.pwd}/test/pdfs/thumb_test_2.png")).must_equal true
    end

    it 'must create thumbs for just one page' do
      @pdf = ::Thumbnailer::PDF.new("#{Dir.pwd}/test/pdfs/test.pdf", ratio: 2, format: 'png', page: 2)
      @pdf.create
      expect(File.exist?("#{Dir.pwd}/test/pdfs/thumb_test_1.png")).must_equal false
      expect(File.exist?("#{Dir.pwd}/test/pdfs/thumb_test_2.png")).must_equal true
    end

    it 'must create thumbs for selected pages' do
      @pdf = ::Thumbnailer::PDF.new("#{Dir.pwd}/test/pdfs/test.pdf", ratio: 2, format: 'png', pages: [2])
      @pdf.create
      expect(File.exist?("#{Dir.pwd}/test/pdfs/thumb_test_1.png")).must_equal false
      expect(File.exist?("#{Dir.pwd}/test/pdfs/thumb_test_2.png")).must_equal true
    end
  end
end
