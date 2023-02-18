# frozen_string_literal: true

FactoryBot.define do
  factory :eve_station, class: "Eve::Station" do
    max_dockable_ship_volume { 1.5 }

    name { Faker::Lorem.word }

    office_rental_cost { 1.5 }

    owner { "" }

    sequence(:race_id)

    reprocessing_efficiency { 1.5 }

    reprocessing_stations_take { 1.5 }

    services { "MyString" }

    sequence(:system_id)

    sequence(:type_id)
  end
end
