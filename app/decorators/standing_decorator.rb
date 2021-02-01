# frozen_string_literal: true

class StandingDecorator
  def standing
    object.standing.round(1).to_s
  end
end
