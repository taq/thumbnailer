module Thumbnailer
  class Files < Base
    attr_reader :collection, :size

    def initialize(path, options = {})
      super(options)
      @collection = Dir.glob(path)
      @size       = @collection.size
    end

    def create
      @collection.each do |path|
        file = File.new(path, @options)
        file.create
      end
    end
  end
end
