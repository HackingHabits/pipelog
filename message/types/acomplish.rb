module Message
  module Types
    class Accomplish

      def initialize(msg)
        @msg = msg
        @db = Backend::Store.get_instance()
      end

      def expectation_exists?
        @db.get(id = @msg['expectation'])
      end



      def index()


        if expectation = expectation_exists?
          uuid = expectation["_source"]["uuid"]

          traceback = @msg["traceback"]
          pass_fail = @msg["pass_fail"]

          report = @db.get(uuid)
          if report
            source = report["_source"]
            if source["events"]
              source["events"] << {
                  "traceback" => traceback,
                  "pass_fail" => pass_fail,
                  "expectation" => @msg['expectation']
              }
            else
              # Create a source event
              source["events"] = [{
                                      "traceback" => traceback,
                                      "pass_fail" => pass_fail,
                                      "expectation" => @msg['expectation']
                                  }]
            end

            @db.index uuid, body: source
          end
        end
      end
    end
  end
end