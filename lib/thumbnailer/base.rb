require "thumbnailer/version"

module Thumbnailer
  class Base
    protected
    attr_accessor :object

    public
    attr_reader :width, :height, :image_width, :image_height, :prefix, :dir, :sequence

    def initialize(options = {})
      @options      = options
      @object       = options[:object]
      @ratio        = options[:ratio] || 2
      @width        = options[:width]
      @height       = options[:height]
      @image_width  = nil
      @image_height = nil
      @prefix       = options[:prefix] || 'thumb_'
      @dir          = options[:dir]
      @sequence     = nil

      extract_image_size
    end

    def output
      path = "#{@dir}/#{@prefix}#{@file}"
      path = path.gsub(/\.(\w+)$/, ".#{@options[:format]}") if @options[:format].to_s.size > 0
      path = insert_page(path)
      path
    end

    def create
      write
    end

    def write
      resize
      @object.write(output)
    end

    private

    def insert_page(path)
      return path if @options[:sequence].to_i <= 0
      matcher = path.match(/(?<prefix>.*)(\.)(?<ext>\w+)$/)
      "#{matcher[:prefix]}_#{@options[:sequence]}.#{matcher[:ext]}"
    end

    def resize
      return if @object.nil?
      @width, @heigth = avail_thumb_size
      @object.resize("#{@width}x#{@height}")
    end

    def extract_image_size
      return if !@object
      @image_width, @image_height = @object[:width], @object[:height]
      avail_thumb_size
    end

    def avail_thumb_size
      width, height = create_prop_size
      @width  = width  if @width.nil?
      @height = height if @height.nil?
    end

    def create_prop_size
      width  = (@image_width  / @ratio).to_i if @image_width
      height = (@image_height / @ratio).to_i if @image_height
      [ width, height ]
    end
  end
end
