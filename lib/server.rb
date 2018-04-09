require 'socket'
require File.join(__dir__, 'app.rb')

class Server
  def initialize(port: 9292)
    @port = port
  end

  def start
    # preload the app since we're pretending we have a db by
    # keeping everything in memory and using ivars
    app

    puts "TCP Server listening on port #{port}" unless app.env == 'test'
    listen
  end

  def stop
    server.flush
    server.close
    exit 0
  end

  private

  attr_reader :port

  def listen
    request_lines = []

    Thread.start(server.accept) do |client|

      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end

      semaphore.synchronize do
        response = app.call(request_lines, client)

        client.puts response.headers
        client.puts response.content
        client.close

        stop if response.shutdown?
      end
    end

    listen
  end

  def semaphore
    @semaphore ||= Mutex.new
  end

  def app
    @app ||= App.new
  end

  def server
    @server ||= TCPServer.new(port)
  end
end
