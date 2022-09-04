require "test_helper"
require "script_ripper/script_writer"
require "script_ripper/code_block"

module ScriptRipper
  class ScriptWriterTest < Minitest::Test
    test "outputs script without group name" do
      code_blocks = [
        CodeBlock.new(description: "Hello World!", code: "echo \"hello world\""),
        CodeBlock.new(description: "Touch a file", code: "touch /tmp/file")
      ]

      io = StringIO.new

      ScriptWriter.call(
        code_blocks: code_blocks,
        io: io,
        from_url: "https://jellyfin.org/docs/general/administration/installing.html"
      )

      expected_output = <<~OUTPUT
        #!/usr/bin/env bash

        # https://jellyfin.org/docs/general/administration/installing.html

        # Hello World!
        echo "hello world"

        # Touch a file
        touch /tmp/file
      OUTPUT

      assert_equal(expected_output, io.string)
    end

    test "outputs script with group name" do
      code_blocks = [
        CodeBlock.new(description: "Hello World!", code: "echo \"hello world\""),
        CodeBlock.new(description: "Touch a file", code: "touch /tmp/file")
      ]

      io = StringIO.new

      ScriptWriter.call(
        code_blocks: code_blocks,
        io: io,
        group_name: "Ubuntu",
        from_url: "https://jellyfin.org/docs/general/administration/installing.html"
      )

      expected_output = <<~OUTPUT
        #!/usr/bin/env bash

        # https://jellyfin.org/docs/general/administration/installing.html
        # Ubuntu

        # Hello World!
        echo "hello world"

        # Touch a file
        touch /tmp/file
      OUTPUT

      assert_equal(expected_output, io.string)
    end

    test "handles multiline code blocks" do
      code_blocks = [
        CodeBlock.new(
          description: "Hello World!",
          code: "sudo service jellyfin status\nsudo systemctl restart jellyfin\nsudo /etc/init.d/jellyfin stop\n"
        )
      ]

      io = StringIO.new

      ScriptWriter.call(
        code_blocks: code_blocks,
        io: io,
        group_name: "Ubuntu",
        from_url: "https://jellyfin.org/docs/general/administration/installing.html"
      )

      expected_output = <<~OUTPUT
        #!/usr/bin/env bash

        # https://jellyfin.org/docs/general/administration/installing.html
        # Ubuntu

        # Hello World!
        sudo service jellyfin status
        sudo systemctl restart jellyfin
        sudo /etc/init.d/jellyfin stop
      OUTPUT

      assert_equal(expected_output, io.string)
    end
  end
end
