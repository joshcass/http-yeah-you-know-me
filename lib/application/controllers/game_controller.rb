module Application
  module Contollers
    class GameController
      def index
        { content: template.index(game) }
      end

      def create(guess: nil, start: false, host: nil)
        return { status: :forbidden} unless valid_request?(guess, start)
        return start_game if start

        record_guess(guess)
        { location: "http://#{host}/game", status: :moved }
      end

      private

      def game
        @game ||= Services::Game.new
      end

      def start_game
        game.start!
        { content: template.create }
      end

      def record_guess(guess)
        game.guess!(guess.to_i)
      end

      def template
        Templates::Game.new
      end

      def valid_request?(guess, start)
        guess || (start && no_game_in_progress?)
      end

      def no_game_in_progress?
        !game.current_game?
      end
    end
  end
end
