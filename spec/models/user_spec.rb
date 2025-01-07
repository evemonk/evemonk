# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it {
    expect(described_class.devise_modules).to eq([:database_authenticatable,
      :rememberable,
      :recoverable,
      :registerable,
      :validatable,
      :confirmable,
      :trackable,
      :zxcvbnable])
  }

  it { expect(subject).to have_many(:characters).dependent(:destroy) }

  it {
    expect(subject).to define_enum_for(:locale).with_values(
      auto_detect: 0,
      english: 1,
      german: 2,
      french: 3,
      japanese: 4,
      korean: 7
    )
  }
end
