require 'rails_helper'

describe Session do
  it { should be_a(ApplicationRecord) }

  it { should define_enum_for(:device).with([:ios, :android]) }

  it { should belong_to(:user) }

  it { should validate_presence_of(:user) }

  pending { should have_secure_token }
end
