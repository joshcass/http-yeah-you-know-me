module Application
  module Templates
    class Sleepy < Base
      def index
        layout { 'yawn...' }
      end
    end
  end
end
