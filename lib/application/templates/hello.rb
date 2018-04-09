module Application
  module Templates
    class Hello < Base
      def initialize(count)
        @count = count
      end

      def index
        layout do
          "Hello World! (#{count})"
        end
      end

      private

      attr_reader :count
    end
  end
end
