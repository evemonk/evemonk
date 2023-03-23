# frozen_string_literal: true

module Resolvers
  class Alliances < Base
    description "Alliances resolver"

    argument :order_by, Types::AlliancesOrderEnum,
      description: "Order Alliances by",
      required: false

    def resolve(order_by: nil)
      Eve::AlliancesQuery.new(order_by).query
    end
  end
end
