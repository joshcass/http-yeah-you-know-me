module Application
  module Services
    class Game
      attr_reader :guess_count

      def start!
        self.answer        = rand(0..100)
        self.guess_count   = 0
        self.current_guess = nil
      end

      def status
        if current_guess > answer
          :too_high
        elsif current_guess < answer
          :too_low
        elsif current_guess == answer
          :correct
        end
      end

      def update(guess:)
        self.current_guess = guess
        self.guess_count   = guess_count + 1
      end

      def current_guess?
        !current_guess.nil?
      end

      def current_game?
        current_guess? && status != :correct
      end

      private

      attr_writer   :guess_count
      attr_accessor :current_guess, :answer
    end
  end
end
