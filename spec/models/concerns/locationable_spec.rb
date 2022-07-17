# frozen_string_literal: true

require "rails_helper"

describe Locationable do
  let(:klass) { Class.new }

  before do
    klass.class_eval do
      include Locationable

      attr_reader :location_id

      def initialize(params = {})
        @location_id = params[:location_id]
      end
    end
  end

  describe "#location" do
    context "when @location is set" do
      subject { klass.new }

      let(:location) { double }

      before { subject.instance_variable_set(:@location, location) }

      specify { expect(subject.location).to eq(location) }
    end

    context "when location is station" do
      let!(:station) { create(:eve_station, id: 60_000_000) }

      subject { klass.new(location_id: 60_000_000) }

      specify { expect(subject.location).to eq(station) }
    end
  end

  describe "#location_formatted" do
    context "when location is eve station" do
      let!(:eve_system) do
        create(:eve_system,
          id: 30_002_187,
          security_status: 1.0)
      end

      let!(:eve_station) do
        create(:eve_station,
          id: 60_008_494,
          system_id: 30_002_187,
          name: "Amarr VIII (Oris) - Emperor Family Academy")
      end

      let!(:character_blueprint) do
        create(:character_blueprint,
          location_id: 60_008_494)
      end

      subject { klass.new(location_id: 60_008_494) }

      specify { expect(subject.location_formatted).to eq("Amarr VIII (Oris) - Emperor Family Academy (1.0)") }
    end
  end
end
