# frozen_string_literal: true

require "rails_helper"

describe Eve::TypesImporter do
  let(:page) { double }

  subject { described_class.new(page) }

  it { should be_a(Eve::BaseImporter) }

  describe "#initialize" do
    context "with page" do
      its(:page) { should eq(page) }
    end

    context "without page" do
      subject { described_class.new }

      its(:page) { should eq(1) }
    end
  end

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    before { expect(subject).to receive(:import_types) }

    before { expect(subject).to receive(:import_other_pages) }

    specify { expect { subject.import }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseTypes) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseTypes) }

      before { expect(EveOnline::ESI::UniverseTypes).to receive(:new).with(page: page).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end

  # private methods

  describe "#import_types" do
    let(:universe_type_id) { double }

    let(:universe_type_ids) { [universe_type_id] }

    let(:esi) { instance_double(EveOnline::ESI::UniverseTypes, universe_type_ids: universe_type_ids) }

    before { expect(subject).to receive(:esi).and_return(esi) }

    context "when eve type not imported" do
      before { expect(Eve::Type).to receive(:exists?).with(id: universe_type_id).and_return(false) }

      before { expect(Eve::UpdateTypeJob).to receive(:perform_later).with(universe_type_id) }

      specify { expect { subject.send(:import_types) }.not_to raise_error }
    end

    context "when eve type is imported" do
      before { expect(Eve::Type).to receive(:exists?).with(id: universe_type_id).and_return(true) }

      before { expect(Eve::UpdateTypeJob).not_to receive(:perform_later) }

      specify { expect { subject.send(:import_types) }.not_to raise_error }
    end
  end

  describe "#import_other_pages" do
    context "when page is more than 1" do
      let(:page) { 2 }

      subject { described_class.new(page) }

      before { expect(Eve::UpdateTypesJob).not_to receive(:perform_later) }

      specify { expect { subject.send(:import_other_pages) }.not_to raise_error }
    end

    context "when total pages is 1" do
      let(:page) { 1 }

      subject { described_class.new(page) }

      let(:esi) { instance_double(EveOnline::ESI::UniverseTypes, total_pages: 1) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      before { expect(Eve::UpdateTypesJob).not_to receive(:perform_later) }

      specify { expect { subject.send(:import_other_pages) }.not_to raise_error }
    end

    context "when page is 1 and total pages more than 1" do
      let(:page) { 1 }

      subject { described_class.new(page) }

      let(:esi) { instance_double(EveOnline::ESI::UniverseTypes, total_pages: 2) }

      before { expect(subject).to receive(:esi).and_return(esi).twice }

      before { expect(Eve::UpdateTypesJob).to receive(:perform_later).with(2) }

      specify { expect { subject.send(:import_other_pages) }.not_to raise_error }
    end
  end
end
