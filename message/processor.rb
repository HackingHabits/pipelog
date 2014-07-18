require "json"

module Message
  class Processor

    # websocket receives a message
    # which is passed to this method as msg
    def process(msg)

      begin
        message = JSON.load(msg)
      rescue Exception => e
        return
      end

      begin
        puts "received #{message['type']}"
        # Determine message type
        if message['type'] == 'logfile'
          m = Message::Types::Logfile.ne  w(message)
        elsif message['type'] == 'log'
          m = Message::Types::Log.new(message)
        end

        # Index the message
        m.index()
      end


    end
  end
end
