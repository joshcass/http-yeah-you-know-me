module Application
  module Templates
    class Datetime < Base
      def initialize(time)
        @time = time
      end

      def index
        layout { time }
      end

      private

      attr_reader :time
    end
  end
end
