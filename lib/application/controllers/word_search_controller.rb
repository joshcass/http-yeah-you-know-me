module Application
  module Contollers
    class WordSearchController
      def index(params)
        return { status: :forbidden } unless word_present?(params)

        { content: Templates::WordSearch.new(predicate(params['word'])).index }
      end

      private

      def predicate(word)
        word_search.known?(word) ? "#{word} is" : "#{word} is not"
      end

      def word_search
        @word_search ||= Services::WordSearch.new
      end

      def word_present?(params)
        !(params['word'].nil? || params['word'].empty?)
      end
    end
  end
end
