$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
$VERBOSE = nil

require 'thumbnailer'
require 'mini_magick'
require 'minitest/autorun'

module MiniTest
  class Spec
    class << self
      alias_method :context, :describe
    end
  end
end
