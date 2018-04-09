require 'forwardable'

module Application
  module Services
    class Game
      extend Forwardable
      def_delegators :game, :guess_count, :current_guess?

      def start!
        self.game = Models::Game.new
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

      def guess!(guess)
        game.update(guess: guess)
      end

      def current_game?
        !game.nil? && current_guess? && status != :correct
      end

      private

      attr_accessor :game
      def_delegators :game, :answer, :current_guess
    end
  end
end
