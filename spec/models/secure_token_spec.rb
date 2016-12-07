require 'rails_helper'

describe SecureToken do
  it { should belong_to(:user) }

  pending { should have_secure_token }

  it { should validate_presence_of(:user) }
end
