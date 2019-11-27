# frozen_string_literal: true

require "rails_helper"

describe Eve::RacesImporter do
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
    context "when fresh data available" do
      let(:url) { double }

      let(:new_etag) { double }

      let(:response) { double }

      let(:race_id) { double }

      let(:as_json) { double }

      let(:race) { instance_double(EveOnline::ESI::Models::Race, race_id: race_id, as_json: as_json) }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseRaces,
          not_modified?: false,
          url: url,
          etag: new_etag,
          races: [race],
          response: response)
      end

      before { expect(EveOnline::ESI::UniverseRaces).to receive(:new).with(language: "en-us").and_return(esi) }

      let(:etag) { instance_double(Eve::Etag, etag: "e3f6a76b4a1287f54966c6253f8f5d6ac6460bc43d47570331b43e0b") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("e3f6a76b4a1287f54966c6253f8f5d6ac6460bc43d47570331b43e0b") }

      let(:eve_race) { instance_double(Eve::Race) }

      before { expect(Eve::Race).to receive(:find_or_initialize_by).with(race_id: race_id).and_return(eve_race) }

      before { expect(eve_race).to receive(:update!).with(as_json) }

      before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when no fresh data available" do
      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseRaces,
          not_modified?: true,
          url: url)
      end

      before { expect(EveOnline::ESI::UniverseRaces).to receive(:new).with(language: "en-us").and_return(esi) }

      let(:etag) { instance_double(Eve::Etag, etag: "e3f6a76b4a1287f54966c6253f8f5d6ac6460bc43d47570331b43e0b") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("e3f6a76b4a1287f54966c6253f8f5d6ac6460bc43d47570331b43e0b") }

      before { expect(Eve::Race).not_to receive(:find_or_initialize_by) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
