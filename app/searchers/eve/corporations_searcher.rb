# frozen_string_literal: true

module Eve
  class CorporationsSearcher
    # attr_reader :query, :scope
    #
    # def initialize(query = nil, scope = Eve::Corporation.all)
    #   @query = query
    #   @scope = scope
    # end
    #
    # def search
    #   ids = Eve::Corporation.search(query, load: false).map(&:id) if query.present?
    #
    #   relation = scope.includes(:alliance, :ceo, :creator, :faction)
    #
    #   relation = relation.where(id: ids) if ids.present?
    #
    #   relation = relation.order(name: :asc) if ids.blank?
    #
    #   relation
    # end
  end
end
