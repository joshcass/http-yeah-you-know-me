RSpec.shared_context 'request spec', shared_context: :metadata do
  before do
    self.class.base_uri 'http://localhost:3000'
    @pid = Process.fork { Server.new(port: 3000).start }
  end

  after { Process.kill('TERM', @pid) }

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
