require 'spec_helper'

RSpec.describe 'Root', type: :request do
  it 'returns requset diagnostics' do
    response = get('/')
    expect(response.body).to eq <<~HTML
      <html>
      <head></head>
      <body>
        <pre>
        Verb: GET
        Path: /
        Protocol: HTTP/1.1
        Host: localhost:3000
        Port: #{nil}
        Origin: #{nil}
        Accept: */*
      </pre>

      </body>
      </html>
    HTML
  end
end
