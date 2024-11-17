# frozen_string_literal: true

class CharacterNavBarComponent < ApplicationComponent
  # @param character [Character]
  # @param current_page [String] Enum: "sheet", "employment_history", "agents", "assets", "loyalty_points", "skills", "mail", "standings", "wallet_journal", "wallet_transactions", "industry_jobs", "blueprints", "manufacturing_jobs", "orders", "training_queue", "certificates", "settings".
  def initialize(character, current_page)
    @character = character
    @current_page = current_page
  end
end
