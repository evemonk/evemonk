# frozen_string_literal: true

module Eve
  class CategoryDecorator < ApplicationDecorator
    decorates_associations :groups
  end
end
