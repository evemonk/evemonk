# frozen_string_literal: true

FactoryBot.define do
  factory :eve_certificate_recommended_type, class: Eve::CertificateRecommendedType do
    sequence(:certificate_id)

    sequence(:type_id)
  end
end
