# Thumbnailer

A simple way to create thumbnails.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'thumbnailer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install thumbnailer

## Usage

### Creating from a file

```ruby
thumb = Thumbnailer::File.new('ruby-logo.png')
thumb.create # creates thumb_ruby-logo.png with 1/10 of the original size
```

### Creating from a file mask

```ruby
thumb = Thumbnailer::Files.new('*.png')
thumb.create # creates thumb_<file>.png files
```

## Creating from a PDF file

```ruby
thumb = Thumbnailer::PDF.new('test.pdf')
thumb.create # creates thumb_<file>_<page>.png files for all pages
```

#### Options

We can send some options to customize the output

```ruby
thumb = Thumbnailer::File.new('ruby-logo.png', prefix: 'custom_thumb_')
thumb.create # creates custom_thumb_ruby-logo.png with 1/10 of the original size

thumb = Thumbnailer::File.new('ruby-logo.png', ratio: 5)
thumb.create # creates thumb_ruby-logo.png with 1/5 of the original size

thumb = Thumbnailer::File.new('ruby-logo.png', dir: '/tmp')
thumb.create # creates thumb_ruby-logo.png on /tmp

thumb = Thumbnailer::File.new('ruby-logo.png', width: 35, height: 35)
thumb.create # creates thumb_ruby-logo.png with 35 x 35 size

thumb = Thumbnailer::PDF.new('test.pdf', page: 2)
thumb.create # creates thumb_<file>_2.png files for page 2

thumb = Thumbnailer::PDF.new('test.pdf', pages: [1, 3])
thumb.create # creates thumb_<file>_<page>.png files for pages 1 and 3
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake test` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/taq/thumbnailer.
