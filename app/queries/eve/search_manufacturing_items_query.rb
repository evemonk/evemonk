# frozen_string_literal: true

module Eve
  class SearchManufacturingItemsQuery < BaseQuery
    attr_reader :search, :scope

    def initialize(search = nil, scope = Eve::Type.published.manufacturing_items)
      @search = search
      @scope = scope
    end

    def query
      if search.present?
        scope.search_by_name(search)
      else
        scope.none
      end
    end
  end
end
