module Application
  module Contollers
    class SleepyController
      def index
        sleep(3)
        { content: Templates::Sleepy.new.index }
      end
    end
  end
end
