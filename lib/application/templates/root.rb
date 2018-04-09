module Application
  module Templates
    class Root < Base
      def initialize(request)
        @request = request
      end

      def index
        layout do
          <<~HTML
            <pre>
              Verb: #{request.http_method}
              Path: #{request.full_path}
              Protocol: #{request.protocol}
              Host: #{request.host}
              Port: #{request.port}
              Origin: #{request.origin}
              Accept: #{request.accept}
            </pre>
          HTML
        end
      end

      private

      attr_reader :request
    end
  end
end
