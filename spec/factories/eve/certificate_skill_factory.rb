# frozen_string_literal: true

FactoryBot.define do
  factory :eve_certificate_skill, class: "Eve::CertificateSkill" do
    certificate factory: :eve_certificate

    sequence(:type_id)

    level { (1..5).to_a.sample }

    skill_level { (1..5).to_a.sample }
  end
end
