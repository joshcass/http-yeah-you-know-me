module Application
  module Services
    class WordSearch
      def known?(word)
        possible_words(word).any?
      end

      def possible_words(word)
        dictionary.select { |dictionary_word| dictionary_word.match?(word) }
      end

      private

      attr_reader :word

      def dictionary
        @dictionary ||= Models::Dictionary.all
      end
    end
  end
end
