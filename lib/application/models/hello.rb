module Application
  module Models
    class Hello
      attr_reader :count

      def initialize
        @count = 0
      end

      def increment_count
        @count += 1
      end
    end
  end
end
