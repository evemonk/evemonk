require 'rails_helper'

describe User do
  it { should have_secure_password }

  it { should validate_presence_of(:email) }

  it { should validate_uniqueness_of(:email).case_insensitive }
end
