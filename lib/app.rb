require File.join(__dir__, 'config', 'boot.rb')

class App
  def call(request_lines, client)
    router.call(request_from(request_lines, client))
  end

  def env
    @env ||= ENV.fetch('APP_ENV', 'development')
  end

  private

  def request_from(request_lines, client)
    Application::Request.new(request_lines, client)
  end

  def router
    @router ||= Application::Router.new
  end
end
