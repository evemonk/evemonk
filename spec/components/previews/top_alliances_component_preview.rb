# frozen_string_literal: true

class TopAlliancesComponentPreview < Lookbook::Preview
  def loading
    render TopAlliancesComponent.new
  end

  def loaded
    render TopAlliancesComponent.new(
      alliances: FactoryBot.build_list(
        :eve_alliance,
        20,
        id: 99_005_338,
        name: "Pandemic Horde",
        corporations_count: 12_345,
        characters_count: 12_345
      )
    )
  end
end
