module Backend
  class Store
    attr_accessor :db

    def initialize()
      @db = Backend::ElasticSearch.new
    end

    def index(*args)
      @db.index(args)
    end

    def self.get_instance()
      return @db if @db

      Backend::Store.new.db
    end
  end
end