# frozen_string_literal: true

module Eve
  class FactionDecorator
    def size_factor
      object.size_factor.to_s
    end
  end
end
