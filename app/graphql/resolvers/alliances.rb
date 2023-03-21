# frozen_string_literal: true

module Resolvers
  class Alliances < Base
    description "Alliances resolver"

    def resolve
      ::Eve::Alliance.order(:id)
    end
  end
end
