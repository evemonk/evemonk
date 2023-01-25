# frozen_string_literal: true

require "rails_helper"

describe Eve::RacesImporter do
  it { should be_a(Eve::BaseImporter) }

  describe "#initialize" do
    context "without locale" do
      its(:locale) { should eq(:en) }
    end

    context "with locale" do
      let(:locale) { :ru }

      subject { described_class.new(locale) }

      its(:locale) { should eq(:ru) }
    end
  end

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    before { expect(subject).to receive(:configure_etag) }

    context "when etag cache hit" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseRaces, not_modified?: true) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when etag cache miss" do
      let(:race_id) { double }

      let(:json) { double }

      let(:race) { instance_double(EveOnline::ESI::Models::Race, race_id: race_id, as_json: json) }

      let(:esi) { instance_double(EveOnline::ESI::UniverseRaces, not_modified?: false, races: [race]) }

      before { expect(subject).to receive(:esi).and_return(esi).twice }

      let(:eve_race) { instance_double(Eve::Race) }

      before { expect(Eve::Race).to receive(:find_or_initialize_by).with(race_id: race_id).and_return(eve_race) }

      before { expect(eve_race).to receive(:update!).with(json) }

      before { expect(subject).to receive(:update_etag) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseRaces) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseRaces) }

      before { expect(EveOnline::ESI::UniverseRaces).to receive(:new).with(language: "en-us").and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
