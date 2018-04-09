module Application
  module Templates
    class WordSearchJson
      def initialize(word)
        @word = word
      end

      def index
        base_json(word).merge(possible_matches_json(word))
      end

      private

      attr_reader :word

      def base_json(word)
        { word: word, is_word: word_search.known?(word) }
      end

      def possible_matches_json(word)
        return {} unless word_search.possible_matches(word).size > 1

        { possible_matches: word_search.possible_matches(word) }
      end

      def word_search
        @word_search ||= Services::WordSearch.new
      end
    end
  end
end
