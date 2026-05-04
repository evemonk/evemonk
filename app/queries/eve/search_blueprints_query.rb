# frozen_string_literal: true

module Eve
  class SearchBlueprintsQuery < BaseQuery
    attr_reader :q, :scope

    def initialize(q = nil, scope = Eve::Blueprint.published.blueprints)
      @q = q
      @scope = scope
    end

    def query
      if q.present?
        scope.search(q)
      else
        scope.none
      end
    end
  end
end
