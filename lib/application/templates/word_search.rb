module Application
  module Templates
    class WordSearch < Base
      def initialize(word)
        @word = word
      end

      def index
        layout { "#{predicate(word)} a known word" }
      end

      private

      attr_reader :word

      def predicate(word)
        word_search.known?(word) ? "#{word} is" : "#{word} is not"
      end

      def word_search
        @word_search ||= Services::WordSearch.new
      end
    end
  end
end
