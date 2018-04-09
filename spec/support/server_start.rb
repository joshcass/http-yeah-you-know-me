RSpec.configure do |config|
  config.before :example, type: :request do
    require 'httparty'
    config.include HTTParty
    self.class.base_uri 'http://localhost:3000'

    def get(*args)
      self.class.get(*args)
    end

    def post(*args)
      self.class.post(*args)
    end

    @thread = Thread.new { Server.new(port: 3000).start }
  end

  config.after :example, type: :request do
    @thread.exit
  end
end
