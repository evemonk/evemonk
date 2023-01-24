# frozen_string_literal: true

require "rails_helper"

describe Eve::RegionContractsImporter do
  let(:region_id) { double }

  let(:page) { double }

  subject { described_class.new(region_id, page) }

  it { should be_a(Eve::BaseImporter) }

  describe "#initialize" do
    its(:region_id) { should eq(region_id) }

    its(:page) { should eq(page) }
  end

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    before { expect(subject).to receive(:remove_all_region_contracts) }

    before { expect(subject).to receive(:import_new_contracts) }

    before { expect(subject).to receive(:import_other_pages) }

    specify { expect { subject.import }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::PublicContracts) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::PublicContracts) }

      before { expect(EveOnline::ESI::PublicContracts).to receive(:new).with(region_id: region_id, page: page).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end

  # private methods

  describe "#region" do
    context "when @region is set" do
      let(:region) { instance_double(Eve::Region) }

      before { subject.instance_variable_set(:@region, region) }

      specify { expect(subject.send(:region)).to eq(region) }
    end

    context "when @region not set" do
      let(:region) { instance_double(Eve::Region) }

      before { expect(Eve::Region).to receive(:find_by!).with(region_id: region_id).and_return(region) }

      specify { expect(subject.send(:region)).to eq(region) }

      specify { expect { subject.send(:region) }.to change { subject.instance_variable_get(:@region) }.from(nil).to(region) }
    end
  end

  describe "#remove_all_region_contracts" do
    let(:region) { instance_double(Eve::Region) }

    before { expect(subject).to receive(:region).and_return(region) }

    before do
      #
      # region.contracts.destroy_all
      #
      expect(region).to receive(:contracts) do
        double.tap do |a|
          expect(a).to receive(:destroy_all)
        end
      end
    end

    specify { expect { subject.send(:remove_all_region_contracts) }.not_to raise_error }
  end

  describe "#import_new_contracts" do
    let(:json) { double }

    let(:contract) { instance_double(EveOnline::ESI::Models::PublicContract, as_json: json) }

    let(:esi) { instance_double(EveOnline::ESI::PublicContracts, contracts: [contract]) }

    before { expect(subject).to receive(:esi).and_return(esi) }

    let(:region) { instance_double(Eve::Region) }

    before { expect(subject).to receive(:region).and_return(region) }

    before do
      #
      # region.contracts.create!(contract.as_json)
      #
      expect(region).to receive(:contracts) do
        double.tap do |a|
          expect(a).to receive(:create!).with(json)
        end
      end
    end

    specify { expect { subject.send(:import_new_contracts) }.not_to raise_error }
  end

  describe "#import_other_pages" do
    context "when page is more than 1" do
      let(:page) { 2 }

      before { expect(Eve::RegionContractsJob).not_to receive(:perform_later) }

      specify { expect { subject.send(:import_other_pages) }.not_to raise_error }
    end

    context "when total pages is 1" do
      let(:page) { 1 }

      let(:esi) { instance_double(EveOnline::ESI::PublicContracts, total_pages: 1) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      before { expect(Eve::RegionContractsJob).not_to receive(:perform_later) }

      specify { expect { subject.send(:import_other_pages) }.not_to raise_error }
    end

    context "when page is 1 and total pages more than 1" do
      let(:page) { 1 }

      let(:esi) { instance_double(EveOnline::ESI::PublicContracts, total_pages: 2) }

      before { expect(subject).to receive(:esi).and_return(esi).twice }

      before { expect(Eve::RegionContractsJob).to receive(:perform_later).with(region_id, 2) }

      specify { expect { subject.send(:import_other_pages) }.not_to raise_error }
    end
  end
end
