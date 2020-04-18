# frozen_string_literal: true

class CharacterOrder < ApplicationRecord
  has_paper_trail

  belongs_to :character
end
