require "test_helper"
require "script_ripper/parser"
require "script_ripper/code_block"

module ScriptRipper
  class ParserTest < Minitest::Test
    test "returns grouped code blocks with descriptions from HTML" do
      html = fixture_file_contents("jellyfin.html")

      code_blocks = Parser.call(html, "h3")

      assert(code_blocks.is_a?(Hash))

      assert_equal([
        "Docker",
        "Unraid Docker",
        "Podman",
        "Install using Installer (x64)",
        "Manual Installation (x86/x64)",
        "Fedora",
        "Debian",
        "Ubuntu"
      ], code_blocks.keys)

      assert(code_blocks.values.flatten.all? { |code_block| code_block.is_a?(CodeBlock) })

      assert_equal([
        CodeBlock.new(
          description: "Download the latest container image.",
          code: "docker pull jellyfin/jellyfin"
        ),
        CodeBlock.new(
          description: <<~DESCRIPTION,
            Create persistent storage for configuration and cache data.
            Either create two directories on the host and use bind mounts:
            Or create two persistent volumes:
          DESCRIPTION
          code: <<~CODE
            mkdir /path/to/config
            mkdir /path/to/cache
          CODE
        ),
        CodeBlock.new(
          description: <<~DESCRIPTION,
            Create persistent storage for configuration and cache data.
            Either create two directories on the host and use bind mounts:
            Or create two persistent volumes:
          DESCRIPTION
          code: <<~CODE
            docker volume create jellyfin-config
            docker volume create jellyfin-cache
          CODE
        )
      ], code_blocks["Docker"])
    end

    test "returns a flat list of code blocks with descriptions from HTML" do
      html = fixture_file_contents("jellyfin.html")

      code_blocks = Parser.call(html)

      assert(code_blocks.is_a?(Array))
      assert(code_blocks.all? { |code_block| code_block.is_a?(CodeBlock) })
      assert_equal(108, code_blocks.length)
    end
  end
end
