# frozen_string_literal: true

require "rails_helper"

describe Eve::GroupsImporter do
  describe "#initialize" do
    context "with page" do
      let(:page) { double }

      let(:esi) { instance_double(EveOnline::ESI::UniverseGroups) }

      before { expect(EveOnline::ESI::UniverseGroups).to receive(:new).with(page: page).and_return(esi) }

      subject { described_class.new(page) }

      its(:page) { should eq(page) }

      its(:esi) { should eq(esi) }
    end

    context "without page" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseGroups) }

      before { expect(EveOnline::ESI::UniverseGroups).to receive(:new).with(page: 1).and_return(esi) }

      its(:page) { should eq(1) }

      its(:esi) { should eq(esi) }
    end
  end

  describe "#import" do
    context "when fresh data available" do
      let(:page) { double }

      subject { described_class.new(page) }

      let(:new_etag) { double }

      let(:response) { double }

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseGroups,
          not_modified?: false,
          etag: new_etag,
          response: response,
          url: url)
      end

      before { expect(EveOnline::ESI::UniverseGroups).to receive(:new).with(page: page).and_return(esi) }

      let(:etag) { instance_double(Eve::Etag, etag: "97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a") }

      before { expect(subject).to receive(:import_groups) }

      before { expect(subject).to receive(:import_other_pages) }

      before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when no fresh data available" do
      let(:page) { double }

      subject { described_class.new(page) }

      let(:etag) { instance_double(Eve::Etag, etag: "97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a") }

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseGroups,
          not_modified?: true,
          url: url)
      end

      before { expect(EveOnline::ESI::UniverseGroups).to receive(:new).with(page: page).and_return(esi) }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a") }

      before { expect(subject).not_to receive(:import_groups) }

      before { expect(subject).not_to receive(:import_other_pages) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  # private methods

  describe "#import_groups" do
    let(:page) { double }

    subject { described_class.new(page) }

    let(:group_id) { double }

    let(:group_ids) { [group_id] }

    let(:esi) { instance_double(EveOnline::ESI::UniverseGroups, group_ids: group_ids) }

    before { expect(EveOnline::ESI::UniverseGroups).to receive(:new).with(page: page).and_return(esi) }

    context "when eve group not imported" do
      before { expect(Eve::Group).to receive(:exists?).with(group_id: group_id).and_return(false) }

      before { expect(Eve::UpdateGroupJob).to receive(:perform_later).with(group_id) }

      specify { expect { subject.send(:import_groups) }.not_to raise_error }
    end

    context "when eve group is imported" do
      before { expect(Eve::Group).to receive(:exists?).with(group_id: group_id).and_return(true) }

      before { expect(Eve::UpdateGroupJob).not_to receive(:perform_later) }

      specify { expect { subject.send(:import_groups) }.not_to raise_error }
    end
  end

  describe "#import_other_pages" do
    context "when page is more than 1" do
      let(:page) { 2 }

      subject { described_class.new(page) }

      let(:esi) { instance_double(EveOnline::ESI::UniverseGroups) }

      before { expect(EveOnline::ESI::UniverseGroups).to receive(:new).with(page: page).and_return(esi) }

      before { expect(Eve::UpdateGroupsJob).not_to receive(:perform_later) }

      specify { expect { subject.send(:import_other_pages) }.not_to raise_error }
    end

    context "when total pages is 1" do
      let(:page) { 1 }

      subject { described_class.new(page) }

      let(:esi) { instance_double(EveOnline::ESI::UniverseGroups, total_pages: 1) }

      before { expect(EveOnline::ESI::UniverseGroups).to receive(:new).with(page: page).and_return(esi) }

      before { expect(Eve::UpdateGroupsJob).not_to receive(:perform_later) }

      specify { expect { subject.send(:import_other_pages) }.not_to raise_error }
    end

    context "when page is 1 and total pages more than 1" do
      let(:page) { 1 }

      subject { described_class.new(page) }

      let(:esi) { instance_double(EveOnline::ESI::UniverseGroups, total_pages: 2) }

      before { expect(EveOnline::ESI::UniverseGroups).to receive(:new).with(page: page).and_return(esi) }

      before { expect(Eve::UpdateGroupsJob).to receive(:perform_later).with(2) }

      specify { expect { subject.send(:import_other_pages) }.not_to raise_error }
    end
  end
end
