# frozen_string_literal: true

module Eve
  class LoyaltyStoreOfferDecorator < ApplicationDecorator
    decorates_associations :corporation, :type
  end
end
