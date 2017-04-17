require "thumbnailer/version"

module Thumbnailer
  class Base
    protected
    attr_accessor :object

    public
    attr_reader :width, :height, :image_width, :image_height, :prefix, :dir

    def initialize(options = {})
      @object       = nil
      @ratio        = options[:ratio] || 10
      @width        = options[:width]
      @height       = options[:height]
      @image_width  = nil
      @image_height = nil
      @prefix       = options[:prefix] || 'thumb_'
      @dir          = options[:dir]
    end

    def output
      "#{@dir}/#{@prefix}#{@file}"
    end

    def write
      resize
      @object.write(output)
    end

    private

    def resize
      return if @object.nil?
      @width, @heigth = avail_thumb_size
      @object.resize("#{@width}x#{@height}")
    end

    def extract_image_size
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
