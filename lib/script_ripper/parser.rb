require "nokogiri"
require "set"

require "script_ripper/code_block"
require "script_ripper/util"

module ScriptRipper
  class Parser
    include Util

    attr_reader :contents
    attr_reader :group_by

    def initialize(contents, group_by = nil)
      @contents = contents
      @group_by = group_by
    end

    def call
      code_blocks = document.css("ol").map do |ordered_list|
        ordered_list.css("li").map do |list_item|
          list_item.css("code").map do |code_element|
            parent_p_element = find_p_parent(code_element)
            if parent_p_element
              # This means the code block is inside a <p/> element
              CodeBlock.new(
                description: parent_p_element.text,
                code: code_element.text,
                nokogiri_list_item: list_item
              )
            else
              # This means the code block is preceded by zero or more <p/> elements
              CodeBlock.new(
                description: list_item.css("p").map(&:text).join("\n"),
                code: code_element.text,
                nokogiri_list_item: list_item
              )
            end
          end
        end
      end.flatten.reject { |code_block| blank?(code_block.code) }

      return code_blocks if blank?(group_by)

      {}.tap do |result|
        code_blocks.each do |code_block|
          grouping = find_previous_grouping_element(find_list_parent(code_block.nokogiri_list_item))

          next if grouping.nil?

          group_name = grouping.text

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
      return previous_element if grouping_names.include?(previous_element.text)

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

    def grouping_names
      @grouping_names ||= Set.new(groupings.map(&:text))
    end

    def find_p_parent(element)
      return nil if element == document.root
      return nil if blank?(element)
      return element if element.name == "p"

      find_p_parent(element.parent)
    end
  end
end
