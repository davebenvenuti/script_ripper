require "test_helper"
require "script_ripper/cli"

module ScriptRipper
  class CLI
    class FakeExit < StandardError
      def initialize(exit_code)
        super("exit #{exit_code}")
      end
    end

    def exit(code = 0)
      raise FakeExit, code
    end
  end

  class CLITest < Minitest::Test
    def setup
      VCR.insert_cassette("downloader")

      @old_stdout = $stdout
      # When debugging is necessary, pass `true` as the second argument $stdout ends up on stdout
      $stdout = IOProxy.new($stdout, false)
    end

    def teardown
      $stdout = @old_stdout
      VCR.eject_cassette
    end

    test "prints usage instructions" do
      assert_raises(CLI::FakeExit, "exit 0") do
        CLI.call(["-h"])
      end

      assert_match("Usage: script_ripper [options] URL [group_name]", $stdout.string)
    end

    test "outputs unfiltered script" do
      CLI.call(["https://jellyfin.org/docs/general/administration/installing.html"])

      assert_equal(fixture_file_contents("jellyfin-unfiltered.sh"), $stdout.string)
    end

    test "outputs script for specific group" do
      CLI.call(["-g", "h3", "https://jellyfin.org/docs/general/administration/installing.html", "Ubuntu"])

      assert_equal(fixture_file_contents("jellyfin-ubuntu.sh"), $stdout.string)
    end
  end
end
