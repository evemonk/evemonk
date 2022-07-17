# frozen_string_literal: true

require "rails_helper"

describe "Blueprints copying feature" do
  it "should render show action" do
    create(:eve_type,
      id: 24_699,
      name_en: "Drake Blueprint",
      published: true,
      is_blueprint: true,
      copying_time: 12_000)

    create(:eve_type,
      id: Eve::Skills::SCIENCE_ID,
      name_en: "Science",
      published: true)

    create(:eve_type,
      id: Eve::Skills::ADVANCED_INDUSTRY_ID,
      name_en: "Advanced Industry",
      published: true)

    create(:eve_dogma_attribute,
      name: "copySpeedBonus",
      # attribute_id: 1,
      published: true)

    visit blueprints_copying_path(id: 24_699)

    # binding.pry
  end
end
