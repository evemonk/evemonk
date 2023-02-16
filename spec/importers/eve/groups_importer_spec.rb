# frozen_string_literal: true

require "rails_helper"

describe Eve::GroupsImporter do
  it { should be_a(Eve::BaseImporter) }

  let(:page) { double }

  subject { described_class.new(page) }

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

    before { expect(subject).to receive(:import_groups) }

    before { expect(subject).to receive(:import_other_pages) }

    specify { expect { subject.import }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseGroups) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseGroups) }

      before { expect(EveOnline::ESI::UniverseGroups).to receive(:new).with(page: page).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end

  # private methods

  describe "#import_groups" do
    let(:group_id) { double }

    let(:group_ids) { [group_id] }

    let(:esi) { instance_double(EveOnline::ESI::UniverseGroups, group_ids: group_ids) }

    before { expect(subject).to receive(:esi).and_return(esi) }

    context "when eve group not imported" do
      before { expect(Eve::Group).to receive(:exists?).with(id: group_id).and_return(false) }

      before { expect(Eve::UpdateGroupJob).to receive(:perform_later).with(group_id) }

      specify { expect { subject.send(:import_groups) }.not_to raise_error }
    end

    context "when eve group is imported" do
      before { expect(Eve::Group).to receive(:exists?).with(id: group_id).and_return(true) }

      before { expect(Eve::UpdateGroupJob).not_to receive(:perform_later) }

      specify { expect { subject.send(:import_groups) }.not_to raise_error }
    end
  end

  describe "#import_other_pages" do
    context "when page is more than 1" do
      let(:page) { 2 }

      before { expect(Eve::UpdateGroupsJob).not_to receive(:perform_later) }

      specify { expect { subject.send(:import_other_pages) }.not_to raise_error }
    end

    context "when total pages is 1" do
      let(:page) { 1 }

      let(:esi) { instance_double(EveOnline::ESI::UniverseGroups, total_pages: 1) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      before { expect(Eve::UpdateGroupsJob).not_to receive(:perform_later) }

      specify { expect { subject.send(:import_other_pages) }.not_to raise_error }
    end

    context "when page is 1 and total pages more than 1" do
      let(:page) { 1 }

      let(:esi) { instance_double(EveOnline::ESI::UniverseGroups, total_pages: 2) }

      before { expect(subject).to receive(:esi).and_return(esi).twice }

      before { expect(Eve::UpdateGroupsJob).to receive(:perform_later).with(2) }

      specify { expect { subject.send(:import_other_pages) }.not_to raise_error }
    end
  end
end
