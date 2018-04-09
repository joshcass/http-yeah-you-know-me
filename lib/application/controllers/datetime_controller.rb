module Application
  module Contollers
    class DatetimeController
      def index
        { content: Templates::Datetime.new(formatted_current_time).index }
      end

      private

      def formatted_current_time
        Time.now.localtime.strftime('%l:%M%p on %A, %B %e, %Y')
      end
    end
  end
end
