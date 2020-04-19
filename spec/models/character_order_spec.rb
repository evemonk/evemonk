# frozen_string_literal: true

require "rails_helper"

describe CharacterOrder do
  it { should be_a(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { should belong_to(:character) }

  it { should belong_to(:type).class_name("Eve::Type").with_primary_key("type_id").with_foreign_key("type_id").optional(true) }

  it { should belong_to(:region).class_name("Eve::Region").with_primary_key("region_id").with_foreign_key("region_id").optional(true) }

  describe "#location" do
    context "when @location is set" do
      subject { build(:character_order) }

      let(:location) { double }

      before { subject.instance_variable_set(:@location, location) }

      specify { expect(subject.location).to eq(location) }
    end

    context "when location is station" do
      let!(:station) { create(:eve_station, station_id: 60_000_000) }

      subject { build(:character_order, location_id: 60_000_000) }

      specify { expect(subject.location).to eq(station) }
    end
  end
end
