# frozen_string_literal: true

module Eve
  class CharacterAttribute < ApplicationRecord
    belongs_to :icon,
      class_name: "Eve::Icon",
      primary_key: "icon_id",
      optional: true
  end
end
