module Zuck
  class ZuckError < StandardError; end
  module Error
    class ReadOnly < ::Zuck::ZuckError; end
    class MissingToken < ::Zuck::ZuckError; end
    class InvalidClass < ::Zuck::ZuckError; end
  end
end
