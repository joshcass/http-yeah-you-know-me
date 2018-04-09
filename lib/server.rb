require 'pry'
class Server
  def initialize(port: 9292)
    @port = port
  end

  def start
    puts "TCP Server listening on port #{port}"
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    puts request_lines
    client.close
    server.close
  end

  private

  attr_reader :port

  def client
    @client ||= server.accept
  end

  def server
    @server ||= TCPServer.new(port)
  end
end
