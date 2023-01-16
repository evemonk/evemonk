# frozen_string_literal: true

class CharacterAgentDivisionsFilterForm
  include ActiveModel::Model

  attr_accessor :filter

  def initialize(filter)
    @filter = filter
  end

  def select_data
    raw_values.map(&:values)
  end

  def selected
    filter
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
