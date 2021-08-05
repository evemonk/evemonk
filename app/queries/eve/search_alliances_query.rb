# frozen_string_literal: true

module Eve
  class SearchAlliancesQuery < BaseQuery
    attr_reader :search, :scope

    def initialize(search = nil, scope = Eve::Alliance.all)
      @search = search
      @scope = scope
    end

    def query
      if search.present?
        scope.search_by_name_and_ticker(search)
      else
        scope
      end
    end
  end
end
