# frozen_string_literal: true

module Eve
  class CharacterRepository
    class << self
      private

      def to_model(attributes)
        Character.new(**attributes.symbolize_keys)
      end
    end
  end
end
