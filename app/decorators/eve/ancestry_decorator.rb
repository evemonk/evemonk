# frozen_string_literal: true

module Eve
  class AncestryDecorator < ApplicationDecorator
    decorates_associations :bloodline, :icon
  end
end
