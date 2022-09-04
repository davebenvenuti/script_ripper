require "optparse"

require "script_ripper/downloader"
require "script_ripper/parser"
require "script_ripper/script_writer"

module ScriptRipper
  class CLI
    attr_reader :arguments, :options, :url, :group_name

    def initialize(arguments = ARGV)
      @arguments = arguments
      @options = {}
    end

    def call
      parse_arguments!

      content = Downloader.call(url)
      code_blocks = Parser.call(content, group_by: group_by)

      if code_blocks.is_a?(Hash)
        ScriptWriter.call(code_blocks: code_blocks[group_name], from_url: url, group_name: group_name)
      else
        ScriptWriter.call(code_blocks: code_blocks, from_url: url)
      end
    end

    class << self
      def call(arguments = ARGV)
        new(arguments).call
      end
    end

    def group_by
      options[:"group-by"]
    end

    private

    attr_reader :option_parser

    def parse_arguments!
      @option_parser = OptionParser.new do |opts|
        opts.banner = "Usage: script_ripper [options] URL [group_name]"

        opts.on(
          "-g GROUPBY",
          "--group-by GROUPBY",
          "Group by an element type (typically something like h2, h3, etc.  Required if group_name is provided."
        )

        opts.on("-h", "--help", "Show this message")

        opts.parse!(arguments, into: options)
      end

      if options["help"]
        puts option_parser
        exit 0
      end

      # opts.parse! is destructive, so whatever remains should be the URL and optional group name
      @url, @group_name = arguments

      print_usage_and_exit_if_arguments_invalid!
    end

    def print_usage_and_exit_if_arguments_invalid!
      fail! if blank?(url)

      return if blank?(group_by) && blank?(group_name)
      return if present?(group_by) && present?(group_name)

      fail!
    end

    def fail!
      puts option_parser
      exit 1
    end

    def present?(value)
      return false if value.nil?
      return false if value.respond_to?(:empty?) && value.empty?

      true
    end

    def blank?(value)
      !present?(value)
    end
  end
end
