require "nokogiri"
require "script_ripper/code_block"

module ScriptRipper
  class Parser
    attr_reader :contents
    attr_reader :group_by

    def initialize(contents, group_by = nil)
      @contents = contents
      @group_by = group_by
    end

    def call
      code_blocks = document.css("ol").map do |ordered_list|
        ordered_list.css("li").map do |list_item|
          CodeBlock.new(
            description: list_item.css("p").map(&:text).join("\n"),
            code: list_item.css("code").text,
            nokogiri_list_item: list_item
          )
        end
      end.flatten.reject { |code_block| code_block.code.nil? || code_block.code.empty? }

      return code_blocks if groupings_hash.empty?

      {}.tap do |result|
        code_blocks.each do |code_block|
          grouping = find_previous_grouping_element(find_list_parent(code_block.nokogiri_list_item))

          group_name = grouping&.text

          result[group_name] ||= []
          result[group_name] << code_block
        end
      end
    end

    class << self
      def call(contents, group_by = nil)
        new(contents, group_by).call
      end
    end

    private

    def find_previous_grouping_element(element)
      previous_element = element&.previous_element

      return nil if previous_element.nil?
      return previous_element if groupings_hash[previous_element.text] == previous_element

      find_previous_grouping_element(previous_element)
    end

    def find_list_parent(list_item)
      return list_item if list_item.name == "ol"
      return nil if list_item.parent.nil?

      find_list_parent(list_item.parent)
    end

    def document
      @document ||= Nokogiri::HTML(contents)
    end

    def groupings
      @groupings ||= document.css(group_by)
    end

    def groupings_hash
      @groupings_hash ||= Hash[groupings.map { |grouping| [grouping.text, grouping] }]
    end
  end
end
