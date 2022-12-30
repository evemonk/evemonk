# frozen_string_literal: true

class CharacterAsset < ApplicationRecord
  include Locationable

  belongs_to :character

  belongs_to :type, class_name: "Eve::Type", optional: true
end
