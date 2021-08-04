# frozen_string_literal: true

module Eve
  class CharactersSearcher
    # attr_reader :query, :scope
    #
    # def initialize(query = nil, scope = Eve::Character.all)
    #   @query = query
    #   @scope = scope
    # end
    #
    # def search
    #   ids = Eve::Character.search(query, load: false).map(&:id) if query.present?
    #
    #   relation = scope.includes(:alliance,
    #     :ancestry,
    #     :bloodline,
    #     :corporation,
    #     :faction,
    #     :race)
    #
    #   relation = relation.where(id: ids) if ids.present?
    #
    #   relation = relation.order(name: :asc) if ids.blank?
    #
    #   relation
    # end
  end
end
