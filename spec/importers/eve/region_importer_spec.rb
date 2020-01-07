# frozen_string_literal: true

require "rails_helper"

describe Eve::RegionImporter do
  describe "#initialize" do
    context "without locale" do
      let(:region_id) { double }

      subject { described_class.new(region_id) }

      its(:region_id) { should eq(region_id) }

      its(:locale) { should eq(:en) }
    end

    context "with locale" do
      let(:region_id) { double }

      let(:locale) { :ru }

      subject { described_class.new(region_id, locale) }

      its(:region_id) { should eq(region_id) }

      its(:locale) { should eq(:ru) }
    end
  end

  describe "#import" do
    context "when fresh data available" do
      context "when market group found" do
        let(:region_id) { double }

        subject { described_class.new(region_id) }

        let(:eve_region) { instance_double(Eve::Region) }

        before { expect(Eve::Region).to receive(:find_or_initialize_by).with(region_id: region_id).and_return(eve_region) }

        let(:json) { double }

        let(:url) { double }

        let(:new_etag) { double }

        let(:response) { double }

        let(:esi) do
          instance_double(EveOnline::ESI::UniverseRegion,
            url: url,
            not_modified?: false,
            etag: new_etag,
            response: response,
            as_json: json)
        end

        before { expect(EveOnline::ESI::UniverseRegion).to receive(:new).with(id: region_id, language: "en-us").and_return(esi) }

        let(:etag) { instance_double(Eve::Etag, etag: "6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

        before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

        before { expect(esi).to receive(:etag=).with("6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

        before { expect(eve_region).to receive(:update!).with(json) }

        before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when group not found" do
        let(:region_id) { double }

        subject { described_class.new(region_id) }

        let(:eve_region) { instance_double(Eve::Region) }

        before { expect(Eve::Region).to receive(:find_or_initialize_by).with(region_id: region_id).and_return(eve_region) }

        before { expect(EveOnline::ESI::UniverseRegion).to receive(:new).with(id: region_id, language: "en-us").and_raise(EveOnline::Exceptions::ResourceNotFound) }

        before { expect(eve_region).to receive(:destroy!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context "when no fresh data available" do
      let(:region_id) { double }

      subject { described_class.new(region_id) }

      let(:eve_region) { instance_double(Eve::Region) }

      before { expect(Eve::Region).to receive(:find_or_initialize_by).with(region_id: region_id).and_return(eve_region) }

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseRegion,
          url: url,
          not_modified?: true)
      end

      before { expect(EveOnline::ESI::UniverseRegion).to receive(:new).with(id: region_id, language: "en-us").and_return(esi) }

      let(:etag) { instance_double(Eve::Etag, etag: "6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

      before { expect(eve_region).not_to receive(:update!) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
