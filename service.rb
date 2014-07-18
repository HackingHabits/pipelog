require 'em-websocket'
require "message/processor"
require "message/types/logfile"
require "message/types/log"
require "backend/elasticsearch"
require "backend/redis"
require "backend/store"


EM.run {
  EM::WebSocket.run(:host => "0.0.0.0", :port => 8080) do |ws|
    puts "Initializing web sockets"
    ws.onopen { |handshake|
      puts "WebSocket connection open"

      # Access properties on the EM::WebSocket::Handshake object, e.g.
      # path, query_string, origin, headers

      # Publish message to the client
      ws.send "Hello Client, you connected to #{handshake.path}"
    }

    ws.onclose { puts "Connection closed" }

    ws.onmessage { |msg|
      puts "Recieved message: #{msg}"

      message_processor = Message::Processor.new
      message_processor.process(msg)

      ws.send "Pong: #{msg}"
    }
  end
}
