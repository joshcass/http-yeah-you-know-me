module Application
  module Contollers
    class WordSearchController
      def index(params, format)
        return { status: :forbidden } unless word_present?(params)

        { content: send(format, params['word']) }
      end

      private

      attr_reader :word

      def html(word)
        Templates::WordSearch.new(word).index
      end

      def json(word)
        JSON.generate Templates::WordSearchJson.new(word).index
      end

      def word_present?(params)
        !(params['word'].nil? || params['word'].empty?)
      end
    end
  end
end
