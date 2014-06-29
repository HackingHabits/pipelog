module Message
  module Types
    class Expectation

      def initialize(msg)
        @msg = msg
        @db = Backend::Store.get_instance()
        puts "df"
      end

      def expectation_exists?
        @db.get(id = @msg['expectation'])
      end


      def index_expectation(expectation, uuid)
        data = {}
        data[:id] = expectation
        data[:uuid] = uuid
        json_data = JSON.dump(data)

        @db.index(expectation, body: json_data)
      end

      def index_expectation_reference(expectation, uuid)
        data = {}
        expectation_list = []

        expectation_list << expectation
        data[uuid] = {
            expectation_list:  expectation_list
        }

        json_data = JSON.dump(data)
        @db.index uuid, body: json_data
      end


      def index()

        if expectation = expectation_exists?
          uuid = expectation["_source"]["uuid"]
        else
          uuid = SecureRandom.uuid # Creating new uuid for this expectation
          index_expectation(@msg['expectation'], uuid)
          index_expectation_reference(@msg['expectation'], uuid)
        end

      end
    end
  end
end