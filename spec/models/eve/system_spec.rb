# frozen_string_literal: true

require "rails_helper"

describe Eve::System do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("system_id") }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name"]) }

  it { expect(described_class.table_name).to eq("eve_systems") }

  it { should belong_to(:constellation).with_primary_key("constellation_id").optional(true) }

  it { should belong_to(:star).with_primary_key("star_id").optional(true) }

  it { should have_many(:stargates).with_primary_key("system_id") }

  it { should have_many(:planets).with_primary_key("system_id") }

  it { should have_many(:moons).with_primary_key("system_id") }

  it { should have_many(:stations).with_primary_key("system_id") }

  it { should have_many(:asteroid_belts).with_primary_key("system_id") }

  it { should have_one(:position).dependent(:destroy) }

  describe "#rounded_security_status" do
    context "when security status is 0.14" do
      subject { build(:eve_system, security_status: 0.14) }

      specify { expect(subject.rounded_security_status).to eq(0.1) }
    end

    context "when security status is 0.15" do
      subject { build(:eve_system, security_status: 0.15) }

      specify { expect(subject.rounded_security_status).to eq(0.2) }
    end
  end
end
