module Application
  module Models
    class Game
      attr_reader :guess_count, :current_guess, :answer

      def initialize
        self.answer        = rand(0..100)
        self.guess_count   = 0
        self.current_guess = nil
      end

      def update(guess:)
        self.current_guess = guess
        self.guess_count   = guess_count + 1
      end

      def current_guess?
        !current_guess.nil?
      end

      private

      attr_writer :guess_count, :current_guess, :answer
    end
  end
end
