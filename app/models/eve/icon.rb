# frozen_string_literal: true

module Eve
  class Icon < ApplicationRecord
    def icon_url
      return icon_file.gsub("res:/ui/texture/icons/", "https://static.evemonk.com/Invasion_1.0/Icons/items/") if icon_file&.start_with?("res:/ui/texture/icons/")

      nil
    end
  end
end
