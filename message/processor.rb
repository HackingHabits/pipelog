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
        if message['type'] == 'expectation'
          m = Message::Types::Expectation.new(message)
        elsif  message['type'] == 'accomplish'
          m = Message::Types::Accomplish.new(message)
        elsif message['type'] == 'notes'
          m = Message::Types::Notes.new(message)
        end

        # Index the message
        m.index()
      end


    end
  end
end