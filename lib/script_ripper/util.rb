module ScriptRipper
  module Util
    def present?(value)
      return false if value.nil?
      return false if value.respond_to?(:empty?) && value.empty?
      return false if value.respond_to?(:length) && value.length == 0

      true
    end

    def blank?(value)
      !present?(value)
    end
  end
end
