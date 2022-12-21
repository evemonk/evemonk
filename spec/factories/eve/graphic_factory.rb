# frozen_string_literal: true

FactoryBot.define do
  factory :eve_graphic, class: "Eve::Graphic" do
    sequence(:graphic_id)

    collision_file { "" }

    graphic_file { "" }

    icon_folder { "" }

    sof_dna { "" }

    sof_fation_name { "" }

    sof_hull_name { "" }

    sof_race_name { "" }
  end
end
