# frozen_string_literal: true

module Eve
  class AlliancesQuery < BaseQuery
    attr_reader :order_by, :scope

    def initialize(order_by = nil, scope = Eve::Alliance.all)
      @order_by = order_by
      @scope = scope
    end

    def query
      case order_by
      when "CORPORATIONS_COUNT_DESC"
        scope.order(corporations_count: :desc)
      when "CORPORATIONS_COUNT_ASC"
        scope.order(corporations_count: :asc)
      when "CHARACTERS_COUNT_DESC"
        scope.order(characters_count: :desc)
      when "CHARACTERS_COUNT_ASC"
        scope.order(characters_count: :asc)
      else
        scope.order(:id)
      end
    end
  end
end
