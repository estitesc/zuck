module Zuck
  module KoalaMethods

    def graph=(new_graph_instance)
      @new_graph_instance = new_graph_instance
      validate_graph
      @graph = @new_graph_instance
    end

    def graph
      @graph
    end

    private

    def validate_graph
      is_koala_facebook_api?
      access_token_present?
    end

    def is_koala_facebook_api?
      unless @new_graph_instance.is_a? ::Koala::Facebook::API
        raise Zuck::Error::InvalidClass.new(incorrect_class_error_message)
      end
    end

    def access_token_present?
      unless @new_graph_instance.access_token.present?
        raise Zuck::Error::MissingToken.new(missing_token_error_message)
      end
    end

    def incorrect_class_error_message
      "#{@new_graph_instance.class} is not a Koala::Facebook::API"
    end

    def missing_token_error_message
      "#{@new_graph_instance} does not work without an access_token"
    end
  end
end
