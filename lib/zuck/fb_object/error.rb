module Zuck
  class ZuckError < StandardError; end
  module Error
    class CreateConnectionsFailed < ::Zuck::ZuckError; end
    class DeleteRequestFailed < ::Zuck::ZuckError; end
    class GetRequestFailed < ::Zuck::ZuckError; end
    class InvalidClass < ::Zuck::ZuckError; end
    class MissingToken < ::Zuck::ZuckError; end
    class PostRequestFailed < ::Zuck::ZuckError; end
    class ReadOnly < ::Zuck::ZuckError; end
  end
end
