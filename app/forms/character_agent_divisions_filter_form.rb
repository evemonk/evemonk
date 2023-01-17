# frozen_string_literal: true

class CharacterAgentDivisionsFilterForm
  include ActiveModel::Model

  attr_accessor :division_id

  def initialize(division_id)
    @division_id = division_id
  end

  def select_data
    raw_values.map(&:values)
  end

  def selected
    division_id
  end

  private

  def raw_values
    divisions = [{name: "Division: All", id: -1}]

    Eve::Division.find_each do |division|
      divisions.append({name: "Division: #{division.name}", id: division.id})
    end

    divisions
  end
end
