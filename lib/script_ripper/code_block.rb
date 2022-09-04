module ScriptRipper
  class CodeBlock
    attr_reader :description, :code, :nokogiri_list_item

    def initialize(description:, code:, nokogiri_list_item: nil)
      @description = description.chomp
      @code = code.chomp
      @nokogiri_list_item = nokogiri_list_item
    end

    def inspect
      { "description" => description, "code" => code }.inspect
    end

    def ==(other_code_block)
      return false unless other_code_block.is_a?(CodeBlock)

      description == other_code_block.description && code == other_code_block.code
    end
  end
end
