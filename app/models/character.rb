# frozen_string_literal: true

class Character < ApplicationRecord
  belongs_to :user

  belongs_to :race, class_name: 'Eve::Race', primary_key: :race_id, optional: true

  belongs_to :bloodline, class_name: 'Eve::Bloodline', primary_key: :bloodline_id, optional: true

  belongs_to :faction, class_name: 'Eve::Faction', primary_key: :faction_id, optional: true
end
