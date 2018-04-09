module Application
  module Templates
    class Hello < Base
      def initialize(count)
        @count = count
      end

      def index
        layout { "Hello World! (#{count})" }
      end

      private

      attr_reader :count
    end
  end
end
