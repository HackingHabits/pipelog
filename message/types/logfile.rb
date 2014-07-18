module Message
  module Types
    class Logfile

      def initialize(msg)
        @msg = msg
        @db = Backend::Store.get_instance()
      end

      def exists?
        @db.get(id = @msg['key'])
      end

      def doc()
        # Generates the document to be indexed
        # from @msg

        data = {
            key: @msg["key"],
            tags: @msg["tags"],
            timestamp: Time.now.strftime("%Y-%m-%d %H:%M:%S")
        }

        data
      end

      def index()
        if @msg['command'] == 'create'
          unless logfile = exists?
            # The list does not exist
            # create it!
            @db.index @msg['key'],  body: JSON.dump(doc)
          end
        elsif @msg["command"] == 'addtags'
          # Tags will be added to
          # existing document
        end
      end
    end
  end
end

