# frozen_string_literal: true

class LoyaltyPoint < ApplicationRecord
  belongs_to :character

  belongs_to :corporation, class_name: "Eve::Corporation", primary_key: :corporation_id, optional: true
end
