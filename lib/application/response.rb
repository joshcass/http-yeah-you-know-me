module Application
  class Response
    attr_reader :content

    def initialize(content:, status:, location: nil, shutdown: false)
      @content  = content
      @status   = status
      @location = location
      @shutdown = shutdown
    end

    def headers
      "#{compose_headers}\r\n\r\n"
    end

    def shutdown?
      shutdown
    end

    private

    attr_reader :status, :location, :shutdown

    def compose_headers
      [
        "HTTP/1.1 #{statuses.fetch(status)}",
        location_header,
        "Date: #{Time.now.utc.strftime('%a, %e %b %Y %H:%M:%S %Z')}",
        "Server: Ruby",
        "Content-Type: text/html; charset=iso-8859-1",
        "Content-Length: #{content.length}"
      ].compact.join("\r\n")
    end

    def location_header
      "Location: #{location}" if location
    end

    def statuses
      {
        ok: '200 OK',
        moved: '301 Moved Permanently',
        not_found: '404 Not Found',
        forbidden: '403 Forbidden',
        error: '500 Internal Server Error'
      }
    end
  end
end
