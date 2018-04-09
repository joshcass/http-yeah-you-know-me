module Application
  module Contollers
    class RootController
      def index(request)
        { content: Templates::Root.new(request).index }
      end
    end
  end
end
