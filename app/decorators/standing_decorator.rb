# frozen_string_literal: true

class StandingDecorator < ApplicationDecorator
  decorates_associations :character, :standingable

  def standing
    object.standing.round(1).to_s
  end
end
