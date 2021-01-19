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

    before { expect(subject).to receive(:configure_etag) }

    context "when etag cache hit" do
      let(:esi) { instance_double(EveOnline::ESI::PublicContracts, not_modified?: true) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      specify { expect { subject.import }.not_to raise_error }
    end
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

  # describe "#import_other_pages" do
  #   context "when page is more than 1" do
  #     let(:page) { 2 }
  #
  #     let(:esi) { instance_double(EveOnline::ESI::PublicContracts) }
  #
  #     before { expect(Eve::RegionContractsJob).not_to receive(:perform_later) }
  #
  #     specify { expect { subject.send(:import_other_pages, esi) }.not_to raise_error }
  #   end
  #
  #   context "when total pages is 1" do
  #     let(:page) { 1 }
  #
  #     let(:esi) { instance_double(EveOnline::ESI::PublicContracts, total_pages: 1) }
  #
  #     before { expect(Eve::RegionContractsJob).not_to receive(:perform_later) }
  #
  #     specify { expect { subject.send(:import_other_pages, esi) }.not_to raise_error }
  #   end
  #
  #   context "when page is 1 and total pages more than 1" do
  #     let(:page) { 1 }
  #
  #     let(:esi) { instance_double(EveOnline::ESI::PublicContracts, total_pages: 2) }
  #
  #     before { expect(Eve::RegionContractsJob).to receive(:perform_later).with(region_id, 2) }
  #
  #     specify { expect { subject.send(:import_other_pages, esi) }.not_to raise_error }
  #   end
  # end
end
