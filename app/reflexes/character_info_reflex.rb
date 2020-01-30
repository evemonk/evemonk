# frozen_string_literal: true

class CharacterInfoReflex < ApplicationReflex
  delegate :current_user, to: :connection
end
