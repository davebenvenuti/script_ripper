$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "script_ripper"
require "minitest/autorun"

require 'webmock/minitest'
require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "test/cassettes"
  config.hook_into :webmock
end

class Minitest::Test
  def fixture_file_contents(filename)
    File.read(File.expand_path("../fixtures/#{filename}", __FILE__))
  end

  class << self
    # https://github.com/rails/rails/blob/main/activesupport/lib/active_support/testing/declarative.rb
    #
    # Helper to define a test method using a String. Under the hood, it replaces
    # spaces with underscores and defines the test method.
    #
    #   test "verify something" do
    #     ...
    #   end
    def test(name, &block)
      test_name = "test_#{name.gsub(/\s+/, '_')}".to_sym
      defined = method_defined? test_name
      raise "#{test_name} is already defined in #{self}" if defined
      if block_given?
        define_method(test_name, &block)
      else
        define_method(test_name) do
          flunk "No implementation provided for #{name}"
        end
      end
    end
  end

  class IOProxy
    def initialize(io, forward_to_original = false)
      @io = io
      @stringio = StringIO.new
      @forward_to_original = forward_to_original
    end

    def method_missing(method, *args, &block)
      @stringio.send(method, *args, &block)
      @io.send(method, *args, &block) if @forward_to_original
    end

    def respond_to_missing?(method, include_private = false)
      @io.respond_to?(method, include_private)
    end

    def string
      @stringio.string
    end
  end
end
