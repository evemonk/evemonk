require 'rails_helper'

describe User do
  it { should be_a(ApplicationRecord) }

  it { should have_many(:secure_tokens).dependent(:destroy) }

  it { should have_many(:api_keys).dependent(:destroy) }

  it { should validate_presence_of(:email) }

  it { should validate_uniqueness_of(:email).case_insensitive }

  it { should have_secure_password }
end
