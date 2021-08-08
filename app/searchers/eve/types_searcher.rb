# frozen_string_literal: true

module Eve
  class TypesSearcher
    # attr_reader :query, :scope
    #
    # def initialize(query = nil, scope = Eve::Type.all)
    #   @query = query
    #   @scope = scope
    # end
    #
    # def search
    #   ids = Eve::Type.search(query, load: false).map(&:id) if query.present?
    #
    #   relation = scope.where(published: true).includes(:type_dogma_attributes, :type_dogma_effects)
    #
    #   relation = relation.where(id: ids) if ids.present?
    #
    #   # TODO: fix this
    #   relation = relation.order(name_en: :asc) if ids.blank?
    #
    #   relation
    # end
  end
end
