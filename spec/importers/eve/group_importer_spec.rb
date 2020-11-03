# frozen_string_literal: true

require "rails_helper"

describe Eve::GroupImporter do
  let(:group_id) { double }

  subject { described_class.new(group_id) }

  it { should be_a(Eve::BaseImporter) }

  describe "#initialize" do
    context "without locale" do
      its(:group_id) { should eq(group_id) }

      its(:locale) { should eq(:en) }
    end

    context "with locale" do
      let(:locale) { :ru }

      subject { described_class.new(group_id, locale) }

      its(:group_id) { should eq(group_id) }

      its(:locale) { should eq(:ru) }
    end
  end

  describe "#import!" do
    context "when eve group found" do
      let(:eve_group) { instance_double(Eve::Group) }

      before { expect(Eve::Group).to receive(:find_or_initialize_by).with(group_id: group_id).and_return(eve_group) }

      let(:json) { double }

      let(:esi) { instance_double(EveOnline::ESI::UniverseGroup, as_json: json) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      before { expect(eve_group).to receive(:update!).with(json) }

      specify { expect { subject.import! }.not_to raise_error }
    end

    context "when eve group not found" do
      let(:eve_group) { instance_double(Eve::Group) }

      before { expect(Eve::Group).to receive(:find_or_initialize_by).with(group_id: group_id).and_return(eve_group) }

      before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      before { expect(eve_group).to receive(:destroy!) }

      specify { expect { subject.import! }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseGroup) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseGroup) }

      before { expect(EveOnline::ESI::UniverseGroup).to receive(:new).with(id: group_id, language: "en-us").and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
