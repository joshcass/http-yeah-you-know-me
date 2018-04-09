module Application
  class Routes
    def root(request)
      action = parse_method(request.http_method)
      root_controller.public_send(action, request)
    end

    def hello(request)
      action = parse_method(request.http_method)
      hello_controller.public_send(action)
    end

    def datetime(request)
      action = parse_method(request.http_method)
      datetime_controller.public_send(action)
    end

    def word_search(request)
      action = parse_method(request.http_method)
      word_search_controller.public_send(action, request.params)
    end

    def start_game(request)
      action = parse_method(request.http_method)
      game_controller.public_send(action, start: true)
    end

    def game(request)
      action = parse_method(request.http_method)
      case action
      when :index then game_controller.index
      when :create then game_controller.create(guess: request.body, host: request.host)
      end
    end

    def force_error(request)
      action = parse_method(request.http_method)
      error_controller.public_send(action)
    end

    def defined?(route)
      self.class.instance_methods(false).include?(route.to_sym)
    end

    private

    def parse_method(http_method)
      case http_method
      when 'GET'  then :index
      when 'POST' then :create
      else raise Exceptions::InvalidHTTPMethod
      end
    end

    def root_controller
      @root_controller ||= Contollers::RootController.new
    end

    def hello_controller
      @hello_controller ||= Contollers::HelloController.new
    end

    def datetime_controller
      @datetime_controller ||= Contollers::DatetimeController.new
    end

    def word_search_controller
      @word_search_controller ||= Contollers::WordSearchController.new
    end

    def game_controller
      @game_controller ||= Contollers::GameController.new
    end

    def error_controller
      @error_controller ||= Contollers::ErrorController.new
    end
  end
end
