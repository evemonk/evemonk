# frozen_string_literal: true

class LoyaltyPoint < ApplicationRecord
  belongs_to :character

  belongs_to :corporation, class_name: "Eve::Corporation", optional: true
end
