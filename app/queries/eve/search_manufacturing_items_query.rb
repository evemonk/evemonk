# frozen_string_literal: true

module Eve
  class SearchManufacturingItemsQuery < BaseQuery
    attr_reader :q, :scope

    def initialize(q = nil, scope = Eve::Type.published.manufacturing_items)
      @q = q
      @scope = scope
    end

    def query
      if q.present?
        scope.search(q)
          .filter(published: true)
          .filter(is_manufacturing_item: true)
          .results
      else
        scope.none
      end
    end
  end
end
