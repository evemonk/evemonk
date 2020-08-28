# frozen_string_literal: true

require "rails_helper"

describe Eve::CategoriesImporter do
  describe "#initialize" do
    let(:esi) { instance_double(EveOnline::ESI::UniverseCategories) }

    before do
      expect(EveOnline::ESI::UniverseCategories).to receive(:new)
        .and_return(esi)
    end

    its(:esi) { should eq(esi) }
  end

  describe "#import" do
    context "when fresh data available" do
      let(:new_etag) { double }

      let(:url) { double }

      let(:response) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseCategories,
          not_modified?: false,
          etag: new_etag,
          url: url,
          response: response)
      end

      before do
        expect(EveOnline::ESI::UniverseCategories).to receive(:new)
          .and_return(esi)
      end

      let(:etag) { instance_double(Eve::Etag, etag: "97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before do
        expect(esi).to receive(:etag=)
          .with("97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      before { expect(subject).to receive(:import_new_categories) }

      before { expect(subject).to receive(:remove_old_categories) }

      before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when no fresh data available" do
      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseCategories,
          url: url,
          not_modified?: true)
      end

      before do
        expect(EveOnline::ESI::UniverseCategories).to receive(:new)
          .and_return(esi)
      end

      let(:etag) { instance_double(Eve::Etag, etag: "97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before do
        expect(esi).to receive(:etag=)
          .with("97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      before { expect(subject).not_to receive(:import_new_categories) }

      before { expect(subject).not_to receive(:remove_old_categories) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  # private methods

  describe "#import_new_categories" do
    let(:remote_category_id) { double }

    let(:remote_categories_ids) { [remote_category_id] }

    let(:esi) do
      instance_double(EveOnline::ESI::UniverseCategories,
        not_modified?: false,
        category_ids: remote_categories_ids)
    end

    before do
      expect(EveOnline::ESI::UniverseCategories).to receive(:new)
        .and_return(esi)
    end

    let(:local_category_id) { double }

    let(:local_categories_ids) { [local_category_id] }

    before do
      #
      # Eve::Category.pluck(:category_id) # => local_categories_ids
      #
      expect(Eve::Category).to receive(:pluck).with(:category_id)
        .and_return(local_categories_ids)
    end

    before do
      #
      # Eve::UpdateCategoryJob.perform_later(category_id)
      #
      expect(Eve::UpdateCategoryJob).to receive(:perform_later).with(remote_category_id)
    end

    specify { expect { subject.send(:import_new_categories) }.not_to raise_error }
  end

  describe "#remove_old_categories" do
    let(:remote_category_id) { double }

    let(:remote_categories_ids) { [remote_category_id] }

    let(:esi) do
      instance_double(EveOnline::ESI::UniverseCategories,
        category_ids: remote_categories_ids)
    end

    before { expect(EveOnline::ESI::UniverseCategories).to receive(:new).and_return(esi) }

    let(:local_category_id) { double }

    let(:local_categories_ids) { [local_category_id] }

    before { expect(Eve::Category).to receive(:pluck).with(:category_id).and_return(local_categories_ids) }

    let(:eve_category) { instance_double(Eve::Category) }

    before { expect(Eve::Category).to receive(:find_or_initialize_by).with(category_id: local_category_id).and_return(eve_category) }

    before { expect(eve_category).to receive(:destroy!) }

    specify { expect { subject.send(:remove_old_categories) }.not_to raise_error }
  end
end
