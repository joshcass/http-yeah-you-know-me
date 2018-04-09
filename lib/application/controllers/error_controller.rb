module Application
  module Contollers
    class ErrorController
      def index
        raise SystemError
      end
    end
  end
end
