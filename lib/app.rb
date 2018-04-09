require File.join(__dir__, 'config', 'boot.rb')

class App
  def call(request_lines)
    router.call(request_from(request_lines))
  end

  def env
    @env ||= ENV.fetch('APP_ENV', 'development')
  end

  private

  def request_from(request_lines)
    Application::Request.new(request_lines)
  end

  def router
    @router ||= Application::Router.new
  end
end
