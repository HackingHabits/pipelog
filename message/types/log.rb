module Message
  module Types
    class Log

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
         data = {}
        ['pretty_name', 'log_key', 'success', 'notes'].each do |k|
          data[k] = @msg["log"][k]
        end

        data['timestamp'] =  Time.now.strftime("%Y-%m-%d %H:%M:%S")

        data
      end


      def index()
        if @msg['command'] == 'add'

          logfile = nil

          unless logfile = exists?
            logfile_create_msg = {
                'key' => @msg['key'],
                'command' => 'create'
            }

            logfile = Logfile.new(logfile_create_msg).index()
            puts "Created new logfile"
          end

          if logfile
            puts "Log file created", logfile
            if logfile['_source']['logs']
              # Add to existing tasks list. We will soon
              # replace this with the update feature in elasticsearch
              logfile['_source']['logs'].push(doc)
            else
              logfile['_source']['logs'] = [doc]
            end

            @db.index @msg['key'], body: JSON.dump(logfile['_source'])
          end

        end
      end

    end
  end
end