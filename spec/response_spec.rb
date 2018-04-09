require 'spec_helper'

RSpec.describe Application::Response do
  before do
    allow(Time).to receive(:now) { double(utc: Time.utc(2000,"jan",1,20,15,1)) }
  end

  describe '#headers' do
    it 'returns the correct headers when no redirect' do
      expect(described_class.new(content: '<html>HI</html>', status: :ok).headers).to eq(
        "HTTP/1.1 200 OK\r\nDate: Sat,  1 Jan 2000 20:15:01 UTC\r\nServer: Ruby\r\nContent-Type: text/html; charset=iso-8859-1\r\nContent-Length: 15\r\n\r\n"
      )
    end

    it 'returns the correct headers with a redirect' do
      expect(described_class.new(content: '', status: :ok, location: 'http://example.com').headers).to eq(
        "HTTP/1.1 200 OK\r\nLocation: http://example.com\r\nDate: Sat,  1 Jan 2000 20:15:01 UTC\r\nServer: Ruby\r\nContent-Type: text/html; charset=iso-8859-1\r\nContent-Length: 0\r\n\r\n"
      )
    end
  end
end
