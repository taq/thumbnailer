module Thumbnailer
  class File < Base
    attr_reader :path

    def initialize(path, options = {})
      super(options)
      @path    = path
      @file    = @options[:file]
      @file    = ::File.basename(@path) if @file.nil? && !@path.nil?
      @dir     = @options[:dir]
      @dir     = ::File.dirname(@path) if @dir.nil? && !@path.nil?
      @prefix  = @options[:prefix] if @options[:prefix]
      @object  = extract_image(@path) if !@options[:object]
    end

    private

    def extract_image(file)
      raise Errno::ENOENT unless ::File.exist?(file)
      @object = ::MiniMagick::Image.open(file)
      extract_image_size
      @object
    end
  end
end
