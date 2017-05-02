require 'rails_helper'

describe ApiKey do
  it { should be_a(ApplicationRecord) }

  it { should define_enum_for(:status).with([:fresh, :active, :disabled]) }

  it { should belong_to(:user) }

  it { should validate_presence_of(:user) }

  it { should validate_presence_of(:key_id) }

  it { should validate_numericality_of(:key_id).only_integer }

  it { should validate_presence_of(:v_code) }
end
