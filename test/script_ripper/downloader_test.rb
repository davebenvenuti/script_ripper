require "test_helper"
require "script_ripper/downloader"

module ScriptRipper
  class DownloaderTest < Minitest::Test
    test "downloads the contents of a URL" do
      VCR.use_cassette("downloader", record: :once) do
        expected_contents = fixture_file_contents("jellyfin.html")

        contents = Downloader.call("https://jellyfin.org/docs/general/administration/installing.html")

        assert_equal(expected_contents, contents)
      end
    end
  end
end
