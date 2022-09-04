require "open-uri"

module ScriptRipper
  class Downloader
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def call
      StringIO.new.tap { |content|
        URI.open(url) do |remote_content|
          content.write(remote_content.read)
        end
      }.string
    end

    class << self
      def call(url)
        new(url).call
      end
    end
  end
end
