module Thumbnailer
  class File < Base
    attr_reader :path

    def initialize(path, options = {})
      super(options)
      @path    = path
      @file    = @options[:file] || ::File.basename(@path)
      @dir     = @options[:dir]  || ::File.dirname(@path)
      @prefix  = @options[:prefix] if @options[:prefix]
      @object  = extract_image(@path) if !@options[:object]
    end

    private

    def extract_image(file)
      raise Errno::ENOENT unless ::File.exist?(file)
      @object = MiniMagick::Image.open(file)
      extract_image_size
      @object
    end
  end
end
