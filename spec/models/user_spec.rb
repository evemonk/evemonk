# frozen_string_literal: true

require "rails_helper"

describe User do
  it { should be_a(ApplicationRecord) }

  it {
    expect(described_class.devise_modules).to eq([:database_authenticatable,
                                                  :rememberable,
                                                  :recoverable,
                                                  :registerable,
                                                  :validatable,
                                                  :confirmable,
                                                  :trackable,
                                                  :authy_authenticatable])
  }

  it { should have_many(:sessions).dependent(:destroy) }

  it { should have_many(:characters).dependent(:destroy) }
end
