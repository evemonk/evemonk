# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::BloodlinesImporter do
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

    let(:bloodline_id) { double }

    let(:json) { double }

    let(:bloodline) { instance_double(EveOnline::ESI::Models::Bloodline, bloodline_id: bloodline_id, as_json: json) }

    let(:esi) { instance_double(EveOnline::ESI::UniverseBloodlines, bloodlines: [bloodline]) }

    before { expect(subject).to receive(:esi).and_return(esi) }

    let(:eve_bloodline) { instance_double(Eve::Bloodline) }

    before { expect(Eve::Bloodline).to receive(:find_or_initialize_by).with(id: bloodline_id).and_return(eve_bloodline) }

    let(:transformed_json) { double }

    before { expect(json).to receive(:transform_keys).with(bloodline_id: :id).and_return(transformed_json) }

    before { expect(eve_bloodline).to receive(:update!).with(transformed_json) }

    specify { expect { subject.import }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseBloodlines) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseBloodlines) }

      before { expect(EveOnline::ESI::UniverseBloodlines).to receive(:new).with(language: "en-us").and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
