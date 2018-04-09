require 'socket'
require File.join(__dir__, 'app.rb')

class Server
  def initialize(port: 9292)
    @port = port
  end

  def start
    app

    puts "TCP Server listening on port #{port}" unless app.env == 'test'
    listen
  end

  private

  attr_reader :port

  def listen
    request_lines = []
    client = server.accept

    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end

    response = app.call(request_lines, client)

    client.puts response.headers
    client.puts response.content
    client.close

    listen unless response.shutdown?
  ensure
    server.close
  end

  def app
    @app ||= App.new
  end

  def server
    @server ||= TCPServer.new(port)
  end
end
