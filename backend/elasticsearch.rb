require 'elasticsearch'
require 'securerandom'

module Backend
  class ElasticSearch
    def initialize()
      @client = Elasticsearch::Client.new log: true
      @client.transport.reload_connections!
      @client.cluster.health

      @index = 'customer'
      @type = 'external'

    end

    def index(id, kwargs={})
      body = kwargs[:body]

      if id
        @client.index index: @index, type: @type, id: id, body: body
      else
        @client.index index: @index, type: @type, body: body
      end
    end

    def get(id)
      doc = nil
      begin
        doc = @client.get index: @index, type: @type, id:id
      rescue Exception => e
      end

      doc
    end

    def search()
    end
  end
end