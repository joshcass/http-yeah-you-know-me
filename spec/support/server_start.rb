RSpec.shared_context 'request spec', shared_context: :metadata do
  before(:example) do
    self.class.base_uri "http://localhost:3000"
    @pid = Process.fork do
      Signal.trap('TERM') { @server.stop }
      @server = Server.new(port: 3000)
      @server.start
    end
    # This kinda sucks but without it the server
    # running in the above process wont be ready
    # when the automated request is sent.
    # I don't know of a better way to handle this
    sleep(0.1)
  end

  after(:example) do
    Process.kill('TERM', @pid)
    Process.waitall
  end

  def get(*args)
    self.class.get(*args)
  end

  def post(*args)
    self.class.post(*args)
  end
end

RSpec.configure do |config|
  config.include HTTParty, type: :request
  config.include_context 'request spec', type: :request
end
