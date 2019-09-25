# frozen_string_literal: true

require "rails_helper"

describe User do
  it { should be_a(ApplicationRecord) }

  it { should define_enum_for(:kind).with_values([:normal, :oauth]) }

  it { should have_many(:sessions).dependent(:destroy) }

  it { should have_many(:characters).dependent(:destroy) }

  it { should have_secure_token(:reset_password_token) }
end
