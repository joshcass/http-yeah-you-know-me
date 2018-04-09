module Application
  module Templates
    class Datetime < Base
      def initialize(time)
        @time = time
      end

      def index
        layout do
          time
        end
      end

      private

      attr_reader :time
    end
  end
end
