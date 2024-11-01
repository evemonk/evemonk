# frozen_string_literal: true

class TopAlliancesComponentPreview < Lookbook::Preview
  def loading
    alliances = Eve::Alliance.none

    render TopAlliancesComponent.new(alliances: alliances, lazy: true)
  end

  def loaded
    alliances = FactoryBot.build_list(
      :eve_alliance,
      20,
      id: 99_005_338,
      name: "Pandemic Horde",
      corporations_count: 12_345,
      characters_count: 12_345
    )

    render TopAlliancesComponent.new(alliances: alliances, lazy: false)
  end
end
