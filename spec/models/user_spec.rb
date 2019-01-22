# frozen_string_literal: true

require 'rails_helper'

describe User do
  it { should be_a(ApplicationRecord) }

  it { should define_enum_for(:kind).with_values([:normal, :oauth]) }

  it { should have_many(:sessions).dependent(:destroy) }

  it { should have_many(:characters).dependent(:destroy) }

  context 'when user registered via email' do
    subject { build(:user) }

    xit { should validate_presence_of(:email) } # TODO: update shoulda-matchers and enable this spec

    xit { should validate_uniqueness_of(:email).case_insensitive } # TODO: update shoulda-matchers and enable this spec
  end

  context 'when user registered via oauth' do
    subject { build(:user, :oauth) }

    xit { should_not validate_presence_of(:email) } # TODO: update shoulda-matchers and enable this spec

    xit { should_not validate_uniqueness_of(:email).case_insensitive } # TODO: update shoulda-matchers and enable this spec
  end

  # it { should have_secure_password } # TODO: validations: false # TODO: update shoulda-matchers and enable this spec

  it { should have_secure_token(:reset_password_token) }
end
