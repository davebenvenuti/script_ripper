module ScriptRipper
  class ScriptWriter
    attr_reader :code_blocks, :from_url, :group_name, :io

    def initialize(code_blocks:, from_url:, group_name: nil, io: $stdout)
      @code_blocks = code_blocks
      @group_name = group_name
      @io = io
      @from_url = from_url
    end

    def call
      io.puts "#!/usr/bin/env bash\n\n"
      io.puts "# #{from_url}\n"
      io.puts "# #{group_name}\n" if group_name
      io.puts "\n"

      code_blocks_count = code_blocks.length

      code_blocks.each_with_index do |code_block, i|
        io.puts(description_to_comment(code_block.description))
        code_suffix = (i == code_blocks_count - 1) ? "\n" : "\n\n"

        io.puts("#{code_block.code}#{code_suffix}")
      end

      # if $record
      #   File.open("test/fixtures/jellyfin-ubuntu.sh", "w") do |file|
      #     file.write(io.string)
      #   end
      # end
    end

    class << self
      def call(code_blocks:, from_url:, group_name: nil, io: $stdout)
        new(code_blocks: code_blocks, from_url: from_url, group_name: group_name, io: io).call
      end
    end

    private

    def description_to_comment(description)
      description.split("\n").map { |line| "# #{line}" }.join("\n")
    end
  end
end
