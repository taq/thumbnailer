$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
$VERBOSE = nil

require 'thumbnailer'
require 'mini_magick'
require 'minitest/autorun'

def clear_thumbs
  Dir.glob("#{Dir.pwd}/test/images/*thumb*.png") do |thumb|
    File.delete(thumb)
  end
end

module MiniTest
  class Spec
    class << self
      alias_method :context, :describe
    end
  end
end
