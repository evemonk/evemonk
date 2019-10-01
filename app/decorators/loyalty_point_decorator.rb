# frozen_string_literal: true

class LoyaltyPointDecorator < ApplicationDecorator
  decorates_associations :character, :corporation
end
