# frozen_string_literal: true

module Eve
  class SearchCharactersQuery < BaseQuery
    attr_reader :search, :scope

    def initialize(search, scope = Eve::Character.all)
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
