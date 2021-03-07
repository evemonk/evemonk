# frozen_string_literal: true

module Eve
  class CharacterAttributeRecord < ApplicationRecord
    # extend Mobility
    #
    # has_paper_trail
    #
    # translates :name
    #
    # belongs_to :icon,
    #   class_name: "Eve::Icon",
    #   primary_key: "icon_id",
    #   optional: true
    #
    # def sanitized_description
    #   Rails::Html::FullSanitizer.new.sanitize(description)
    # end
  end
end
