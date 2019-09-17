# frozen_string_literal: true

module Eve
  class AlliancesSearcher
    attr_reader :query, :scope

    def initialize(query = nil, scope = Eve::Alliance.all)
      @query = query
      @scope = scope
    end

    def search
      ids = Eve::Alliance.search(query, load: false).map(&:id) if query.present?

      relation = scope.includes(:faction, :creator_corporation,
        :creator, :executor_corporation)

      relation = relation.where(id: ids) if ids.present?

      relation = relation.order(name: :asc) if ids.blank?

      relation
    end
  end
end
