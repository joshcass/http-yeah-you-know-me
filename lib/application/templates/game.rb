module Application
  module Templates
    class Game < Base
      def create
        layout { 'Good luck!' }
      end

      def index(game)
        layout do
          [
            "<p>Guess count: #{game.guess_count}</p>",
            (current_guess_markup(game.status) if game.current_guess?)
          ].join
        end
      end

      private

      def current_guess_markup(status)
        "<p>Current guess is #{humanize_symbol(status)}</p>"
      end

      def humanize_symbol(symbol)
        symbol.to_s.tr('_', ' ')
      end
    end
  end
end
