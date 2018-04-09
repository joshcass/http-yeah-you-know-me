module Application
  class Response
    attr_reader :content

    def initialize(content:, status:, redirect: nil, shutdown: false)
      @content  = content
      @status   = status
      @redirect = redirect
      @shutdown = shutdown
    end

    def headers
      "#{compose_headers}\r\n\r\n"
    end

    def shutdown?
      shutdown
    end

    private

    attr_reader :status, :redirect, :shutdown

    def compose_headers
      [
        "HTTP/1.1 #{statuses.fetch(status)}",
        location,
        "Date: #{Time.now.utc.strftime('%a, %e %b %Y %H:%M:%S %Z')}",
        "Server: Ruby",
        "Content-Type: text/html; charset=iso-8859-1",
        "Content-Length: #{content.length}"
      ].compact.join("\r\n")
    end

    def location
      "Location: #{redirect}" if redirect
    end

    def statuses
      {
        ok: '200 OK',
        not_found: '404 Not Found',
        forbidden: '403 Forbidden',
        error: '500 Internal Server Error'
      }
    end
  end
end
