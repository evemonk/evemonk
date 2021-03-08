require "rails_helper"

describe Eve::Race do
  let(:attributes) do
    attributes_for(:eve_race).merge(id: 1,
      created_at: Time.zone.now,
      updated_at: Time.zone.now)
  end

  subject { described_class.new(**attributes) }

  it { should be_a(Upgrow::Model) }
end
