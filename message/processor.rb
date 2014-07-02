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
        if message['type'] == 'todolist'
          m = Message::Types::TodoList.new(message)
        elsif message['type'] == 'task'
          m = Message::Types::Task.new(message)
        end

        # Index the message
        m.index()
      end


    end
  end
end
