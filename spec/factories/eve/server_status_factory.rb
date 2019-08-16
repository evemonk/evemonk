# frozen_string_literal: true

FactoryBot.define do
  factory :eve_server_status, class: Eve::ServerStatus do
    sequence(:players)
    server_version { Faker::App.version }
    start_time { Time.zone.now }
    vip { [true, false].sample }
  end
end
