# frozen_string_literal: true

module Eve
  class AlliancesSearcher
    attr_reader :q, :scope

    def initialize(q = nil, scope = Eve::Alliance.all)
      @q = q
      @scope = scope
    end

    def query
      ids = Eve::Alliance.search(q, load: false).map(&:id) if q.present?

      relation = scope.includes(:faction, :creator_corporation,
                                :creator, :executor_corporation)

      relation = relation.where(id: ids) if ids.present?

      relation
    end
  end
end
