# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::RegionImporter do
  let(:region_id) { double }

  subject { described_class.new(region_id) }

  it { expect(subject).to be_a(Eve::BaseImporter) }

  describe "#initialize" do
    context "without locale" do
      its(:region_id) { is_expected.to eq(region_id) }

      its(:locale) { is_expected.to eq(:en) }
    end

    context "with locale" do
      let(:locale) { :ru }

      subject { described_class.new(region_id, locale) }

      its(:region_id) { is_expected.to eq(region_id) }

      its(:locale) { is_expected.to eq(:ru) }
    end
  end

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    let(:eve_region) { instance_double(Eve::Region) }

    before { expect(Eve::Region).to receive(:find_or_initialize_by).with(region_id: region_id).and_return(eve_region) }

    context "when eve region found" do
      let(:json) { double }

      let(:esi) { instance_double(EveOnline::ESI::UniverseRegion, as_json: json) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      before { expect(eve_region).to receive(:update!).with(json) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when eve region not found" do
      before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      before do
        #
        # Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Region ID #{region_id}")
        #
        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info).with("EveOnline::Exceptions::ResourceNotFound: Eve Region ID #{region_id}")
          end
        end
      end

      before { expect(eve_region).to receive(:destroy!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseRegion) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseRegion) }

      before { expect(EveOnline::ESI::UniverseRegion).to receive(:new).with(id: region_id, language: "en-us").and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
