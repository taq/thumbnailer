module Thumbnailer
  class PDF < Base
    attr_reader :collection, :size, :format

    def initialize(path, options = {})
      super(options)
      @path       = path
      @collection = extract_collection
      @size       = @collection.size
      @format     = options[:format] || 'png'
    end

    def create
      extract_page
      extract_pages
      sequences = extract_sequences

      @collection.each do |image|
        sequence = sequences.next
        image.format(@format, 1)

        @options[:object]   = image
        @options[:format]   = @format
        @options[:sequence] = sequence

        file = File.new(@path, @options)
        file.create
      end
    end

    private

    def extract_sequences
      return (1..@collection.size).to_a.each if !@options[:page] && !@options[:pages]
      return [ @options[:page] ].each        if  @options[:page]
      return @options[:pages].each           if  @options[:pages]
    end

    def extract_page
      return if !@options[:page]
      @collection = [ @collection[@options[:page] - 1] ] 
    end

    def extract_pages
      return if !@options[:pages]
      @collection = @options[:pages].map { |page| @collection[page - 1] }
    end

    def extract_collection
      ::MiniMagick::Image.open(@path).pages
    end
  end
end

