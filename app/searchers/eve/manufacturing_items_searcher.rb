ManufactutingItemsSearcher

# frozen_string_literal: true

module Eve
  class BlueprintsSearcher
    attr_reader :query, :scope

    def initialize(query, scope = Eve::Blueprint.all)
      @query = query
      @scope = scope
    end
  end
end
