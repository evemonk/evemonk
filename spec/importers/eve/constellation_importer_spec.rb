# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::ConstellationImporter do
  let(:constellation_id) { double }

  subject { described_class.new(constellation_id) }

  it { expect(subject).to be_a(Eve::BaseImporter) }

  describe "#initialize" do
    context "without locale" do
      its(:constellation_id) { is_expected.to eq(constellation_id) }

      its(:locale) { is_expected.to eq(:en) }
    end

    context "with locale" do
      let(:locale) { :ru }

      subject { described_class.new(constellation_id, locale) }

      its(:constellation_id) { is_expected.to eq(constellation_id) }

      its(:locale) { is_expected.to eq(:ru) }
    end
  end

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    let(:eve_constellation) { instance_double(Eve::Constellation) }

    before { expect(Eve::Constellation).to receive(:find_or_initialize_by).with(constellation_id: constellation_id).and_return(eve_constellation) }

    context "when eve constellation found" do
      let(:json) { double }

      let(:position_json) { double }

      let(:position) { instance_double(EveOnline::ESI::Models::Position, as_json: position_json) }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseConstellation,
          position: position,
          as_json: json)
      end

      before { expect(subject).to receive(:esi).and_return(esi).twice }

      before { expect(eve_constellation).to receive(:update!).with(json) }

      before do
        #
        # eve_constellation.position&.destroy
        #
        expect(eve_constellation).to receive(:position) do
          double.tap do |a|
            expect(a).to receive(:destroy)
          end
        end
      end

      before do
        #
        # eve_constellation.create_position!(esi.position.as_json)
        #
        expect(eve_constellation).to receive(:create_position!).with(position_json)
      end

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when eve constellation not found" do
      before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      before do
        #
        # Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Constellation ID #{constellation_id}")
        #
        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info).with("EveOnline::Exceptions::ResourceNotFound: Eve Constellation ID #{constellation_id}")
          end
        end
      end

      before { expect(eve_constellation).to receive(:destroy!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseConstellation) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseConstellation) }

      before { expect(EveOnline::ESI::UniverseConstellation).to receive(:new).with(id: constellation_id, language: "en-us").and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
