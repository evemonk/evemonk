# frozen_string_literal: true

module Eve
  class IconDecorator < ApplicationDecorator
    def icon_url
      return icon_file.gsub("res:/ui/texture/icons/", "https://static.evemonk.com/sde/Icons/items/") if icon_file.start_with?("res:/ui/texture/icons/")

      nil
    end
  end
end
