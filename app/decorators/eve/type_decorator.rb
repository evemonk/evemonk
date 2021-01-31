# frozen_string_literal: true

module Eve
  class TypeDecorator < ApplicationDecorator
    # include ActionView::Helpers::TextHelper
    include ActionView::Helpers::NumberHelper

    # TODO: add :dogma_effects
    decorates_associations :graphic, :group, :icon, :market_group,
      :type_dogma_attributes, :dogma_attributes, :type_dogma_effects
  end
end
