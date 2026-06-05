# frozen_string_literal: true

class UpdateCharactersJob < ApplicationJob
  queue_as :realtime

  def perform
    # CharacterScope.find_each do |character_scope|
    # end
  end
end
