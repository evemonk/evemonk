# frozen_string_literal: true

module Eve
  class SearchCharactersQuery < BaseQuery
    # @param q [String, ActionController::Parameters, NilClass] String to search. Default: nil
    # @param limit [Integer] Limit records. Default: 25
    # @param scope [Eve::Character::ActiveRecord_Relation]
    def initialize(q: nil, limit: 25, scope: Eve::Character.all)
      @q = q
      @limit = limit
      @scope = scope
    end

    def query
      if @q.present?
        Eve::Character.search(@q, scope: @scope)
          .limit(@limit)
          .results
      else
        @scope.limit(@limit)
      end
    end
  end
end
