# frozen_string_literal: true

class TopCorporationsComponentPreview < Lookbook::Preview
  def loading
    corporations = Eve::Corporation.none

    render TopCorporationsComponent.new(corporations: corporations, lazy: true)
  end

  def loaded
    corporations = FactoryBot.build_list(
      :eve_corporation,
      20,
      id: 98_258_093,
      name: "Strategic Exploration and Development Corp",
      member_count: 12_345
    )

    render TopCorporationsComponent.new(corporations: corporations, lazy: false)
  end
end
