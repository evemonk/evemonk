# frozen_string_literal: true

module Eve
  class SearchBlueprintsQuery < BaseQuery
    attr_reader :search, :scope

    def initialize(search = nil, scope = Eve::Type.published_blueprints)
      @search = search
      @scope = scope
    end

    def query
      if search.present?
        scope.search_by_name(search)
      else
        scope
      end
    end
  end
end
