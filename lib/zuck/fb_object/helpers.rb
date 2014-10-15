module Zuck
  module FbObject
    module Helpers

      private

      def get(graph, path)
        begin
          graph.get_object(path, fields: known_keys.compact.join(','))
        rescue => error
          error_message = "#{error} graph.get_object(#{path.to_json})"
          raise Zuck::Error::GetRequestFailed.new(error_message)
        end
      end

      def create_connection(graph, parent, connection, args = {}, opts = {})
        begin
          graph.put_connections(parent, connection, args, opts)
        rescue => error
          error_message = "#{error} graph.put_connections(#{parent.to_json}, #{connection.to_json}, #{args.to_json}, #{opts.to_json})"
          raise Zuck::Error::CreateConnectionsFailed.new(error_message)
        end
      end

      def post(graph, path, data, opts = {})
        begin
          graph.graph_call(path.to_s, data, "post", opts)
        rescue => error
          error_message = "#{error} graph.graph_call(#{path.to_json}, #{data.to_json}, \"post\", #{opts.to_json})"
          raise Zuck::Error::PostRequestFailed.new(error_message)
        end
      end

      def delete(graph, path)
        begin
          graph.delete_object(path)
        rescue => error
          error_message =  "#{error} graph.delete(#{path.to_json})"
          raise Zuck::Error::DeleteRequestFailed.new(error_message)
        end
      end

      def path_with_parent(parent=nil)
        paths = []
        paths << parent.path if parent
        paths << list_path
        paths.join('/')
      end
    end
  end
end
