module Application
  class Router
    def call(request)
      request_total.increment_count
      respond_with response(request)
    end

    private

    attr_reader :request_count

    def response(request)
      return shutdown if request.shutdown?
      return not_found unless routes.defined?(request.route_name)

      routes.public_send(request.route_name, request)
    rescue Exception => e
      error(e)
    end

    def not_found
      { stautus: :not_found }
    end

    def error(e)
      { content: "#{e.message}\n#{e.backtrace.join("\n")}", status: :error }
    end

    def shutdown
      { shutdown: true, content: "Total Requests: #{request_total.count}" }
    end

    def routes
      @routes ||= Routes.new
    end

    def respond_with(content: '', status: :ok, location: nil, shutdown: false)
      Response.new(
        content: content,
        status: status,
        location: location,
        shutdown: shutdown
      )
    end

    def request_total
      @request_total ||= Services::RequestTotal.new
    end
  end
end
