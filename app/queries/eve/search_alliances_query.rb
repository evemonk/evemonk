# frozen_string_literal: true

module Eve
  class SearchAlliancesQuery < BaseQuery
    # @param q [String, ActionController::Parameters, NilClass] String to search. Default: nil
    # @param limit [Integer] Limit records. Default: 25
    # @param scope [Eve::Alliance::ActiveRecord_Relation]
    def initialize(q: nil, limit: 25, scope: Eve::Alliance.all)
      @q = q
      @limit = limit
      @scope = scope
    end

    def query
      if @q.present?
        Eve::Alliance.search(@q, scope: @scope)
          .limit(@limit)
          .results
      else
        @scope.limit(@limit)
      end
    end
  end
end
