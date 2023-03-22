# frozen_string_literal: true

class CharacterOrder < ApplicationRecord
  include Locationable

  belongs_to :character

  belongs_to :type, class_name: "Eve::Type", optional: true

  belongs_to :region, class_name: "Eve::Region", optional: true
end
