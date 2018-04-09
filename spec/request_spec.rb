require 'spec_helper'

RSpec.describe Application::Request do
  let(:request_lines) do
    ['GET /index?param=value HTTP/1.1',
     'Accept: */*',
     'User-Agent: Ruby',
     'Connection: close',
     'Host: localhost:3000',
     'Port: 3000',
     'Origin: localhost',
     'Content-Length: 1']
  end
  let(:client)  { double }
  let(:subject) { described_class.new(request_lines, client) }

  before do
    allow(client).to receive(:read) { '1' }
  end

  specify { expect(subject.http_method).to eq 'GET' }
  specify { expect(subject.full_path).to eq '/index?param=value' }
  specify { expect(subject.protocol).to eq 'HTTP/1.1' }
  specify { expect(subject.base_path).to eq '/index' }
  specify { expect(subject.params).to eq({ 'param' => 'value' }) }
  specify { expect(subject.accept).to eq '*/*' }
  specify { expect(subject.user_agent).to eq 'Ruby' }
  specify { expect(subject.host).to eq 'localhost:3000' }
  specify { expect(subject.port).to eq '3000' }
  specify { expect(subject.origin).to eq 'localhost' }
  specify { expect(subject.content_length).to eq '1' }
  specify { expect(subject.body).to eq( '1' ) }

  describe '#format' do
    it 'returns json if requested' do
      request_lines[1] = 'Accept: application/json'
      expect(subject.format).to eq :json
    end

    it 'returns html otherwise' do
      expect(subject.format).to eq :html
    end
  end
end
