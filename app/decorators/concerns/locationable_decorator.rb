# frozen_string_literal: true

module LocationableDecorator
  include ActiveSupport::Concern

  decorates_association :location

  # def location_formatted
  #   "Aloha"
  # end
end
