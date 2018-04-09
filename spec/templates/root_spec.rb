require 'spec_helper'

RSpec.describe Application::Templates::Root do
  let(:request_lines) do
    ['GET /index HTTP/1.1',
     'Host: 127.0.0.1',
     'Port: 9292',
     'Origin: 127.0.0.1',
     'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8']
  end

  let(:request) { Application::Request.new(request_lines) }

  let(:subject) { described_class.new(request) }

  describe '#index' do
    it 'returns the expected html' do
      expect(subject.index).to eq <<~EXPECTED
        <html>
        <head></head>
        <body>
          <pre>
          Verb: GET
          Path: /index
          Protocol: HTTP/1.1
          Host: 127.0.0.1
          Port: 9292
          Origin: 127.0.0.1
          Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
        </pre>

        </body>
        </html>
      EXPECTED
   end
  end
end
