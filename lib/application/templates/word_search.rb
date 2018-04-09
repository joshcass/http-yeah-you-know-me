module Application
  module Templates
    class WordSearch < Base
      def initialize(predicate)
        @predicate = predicate
      end

      def index
        layout { "#{predicate} a known word" }
      end

      private

      attr_reader :predicate
    end
  end
end
