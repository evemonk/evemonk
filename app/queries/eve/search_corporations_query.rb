# frozen_string_literal: true

module Eve
  class SearchCorporationsQuery < BaseQuery
    attr_reader :q, :scope

    def initialize(q = nil, scope = Eve::Corporation.all)
      @q = q
      @scope = scope
    end

    def query
      if q.present?
        scope.search(q)
      else
        scope
      end
    end
  end
end
