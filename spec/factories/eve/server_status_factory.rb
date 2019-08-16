# frozen_string_literal: true

FactoryBot.define do
  factory :eve_server_status, class: 'Eve::ServerStatus' do
    players { "" }
    server_version { "MyString" }
    start_time { "2019-08-16 16:20:00" }
    vip { false }
  end
end
