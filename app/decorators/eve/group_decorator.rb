# frozen_string_literal: true

module Eve
  class GroupDecorator < ApplicationDecorator
    decorates_associations :category, :types
  end
end
