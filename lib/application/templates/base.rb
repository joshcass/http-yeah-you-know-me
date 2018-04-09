module Application
  module Templates
    class Base
      def layout(&block)
        <<~LAYOUT
          <html>
          <head></head>
          <body>
            #{yield}
          </body>
          </html>
        LAYOUT
      end
    end
  end
end
