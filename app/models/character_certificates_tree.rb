# frozen_string_literal: true

class CharacterCertificatesTree
  attr_reader :character

  def initialize(character)
    @character = character
  end

  def preload
    self
  end
end
