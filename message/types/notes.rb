module Message
  module Types
    class Notes

      def initialize(msg)
        @msg = msg
        @db = Backend::Store.get_instance()
      end

      def note_exists?
        @db.get(id = @msg['note_id']) if @msg['note_id']
      end

      def index()
        data = {}

        if @msg['notes'].size == 1
          data["notes"] = [@msg['notes']]
        elsif @msg['notes'].size > 1
          data["notes"] = @msg['notes']
        end

        if note = note_exists?
          existing_notes = note["_source"]["notes"]
          data["notes"] += existing_notes
        end

        json_data = JSON.dump(data)
        @db.index @msg['note_id'], body: json_data
      end

    end
  end
end