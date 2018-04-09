module Application
  module Contollers
    class HelloController
      def index
        { content: Templates::Hello.new(hello.count).index }.tap do
          hello.increment_count
        end
      end

      private

      def hello
        @hello ||= Models::Hello.new
      end
    end
  end
end
