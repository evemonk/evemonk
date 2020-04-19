# frozen_string_literal: true

require "rails_helper"

describe Locationable do
  before do
    class A
      include Locationable

      attr_reader :location_id

      def initialize(params = {})
        @location_id = params[:location_id]
      end
    end
  end

  describe "#location" do
    context "when @location is set" do
      subject { A.new }

      let(:location) { double }

      before { subject.instance_variable_set(:@location, location) }

      specify { expect(subject.location).to eq(location) }
    end

    context "when location is station" do
      let!(:station) { create(:eve_station, station_id: 60_000_000) }

      subject { A.new(location_id: 60_000_000) }

      specify { expect(subject.location).to eq(station) }
    end
  end
end
