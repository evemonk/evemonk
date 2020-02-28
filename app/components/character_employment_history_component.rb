# frozen_string_literal: true

class CharacterEmploymentHistoryComponent < ActionView::Component::Base
  attr_reader :character_corporation_histories, :counter

  def initialize(character_corporation_histories:, counter:)
    @character_corporation_histories = character_corporation_histories
    @counter = counter
  end
end
