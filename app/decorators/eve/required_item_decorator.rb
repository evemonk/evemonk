# frozen_string_literal: true

module Eve
  class RequiredItemDecorator < ApplicationDecorator
    decorates_associations :loyalty_store_offer, :type
  end
end
