module Message
  module Types
    class Task

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
            name: @msg["details"]["pretty_name"],
            task_key: @msg["details"]["task_key"],
            success: @msg["details"]["success"],
            notes: @msg["details"]["notes"],
            timestamp: Time.now.strftime("%Y-%m-%d %H:%M:%S")
        }

        data
      end


      def index()
        if @msg['command'] == 'add'
          if todolist = exists?
            # A to-do list with the key exists
            # we will update the tasks on it

            if todolist["_source"]["tasks"]
              # Add to existing tasks list
              todolist["_source"]["tasks"].push(doc)
            else
              todolist["_source"]["tasks"] = [doc]
            end

            @db.index @msg["key"], body: JSON.dump(todolist["_source"])
          end
        end
      end

    end
  end
end