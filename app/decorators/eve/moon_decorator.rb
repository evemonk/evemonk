# frozen_string_literal: true

module Eve
  class MoonDecorator < ApplicationDecorator
    decorates_associations :system, :planet, :position
  end
end
