# frozen_string_literal: true

class TopAlliancesComponentPreview < Lookbook::Preview
  def loaded
    render TopAlliancesComponent.new(
      alliances: FactoryBot.build_list(:eve_alliance, 20, id: 99_005_338, name: "Pandemic Horde")
    )
  end

  def loading
    render TopAlliancesComponent.new(alliances: nil)
  end
end
