# frozen_string_literal: true

FactoryBot.define do
  factory :character_mail_label do
    character

    color { ["#666666", "#999999", "#ffffff"].sample }

    sequence(:label_id)

    name { ["Inbox", "Sent", "[Corp]", "[Alliance]"].sample }

    unread_count { 0 }
  end
end
