# frozen_string_literal: true

require "rails_helper"

describe Eve::CategoriesImporter do
  it { should be_a(Eve::BaseImporter) }

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    before { expect(subject).to receive(:import_new_categories) }

    before { expect(subject).to receive(:remove_old_categories) }

    specify { expect { subject.import }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseCategories) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseCategories) }

      before { expect(EveOnline::ESI::UniverseCategories).to receive(:new).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end

  # private methods

  describe "#import_new_categories" do
    let(:remote_category_id) { double }

    let(:remote_categories_ids) { [remote_category_id] }

    let(:esi) { instance_double(EveOnline::ESI::UniverseCategories, category_ids: remote_categories_ids) }

    before { expect(subject).to receive(:esi).and_return(esi) }

    let(:local_category_id) { double }

    let(:local_categories_ids) { [local_category_id] }

    before do
      #
      # Eve::Category.ids # => local_categories_ids
      #
      expect(Eve::Category).to receive(:ids).and_return(local_categories_ids)
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

    let(:esi) { instance_double(EveOnline::ESI::UniverseCategories, category_ids: remote_categories_ids) }

    before { expect(subject).to receive(:esi).and_return(esi) }

    let(:local_category_id) { double }

    let(:local_categories_ids) { [local_category_id] }

    before { expect(Eve::Category).to receive(:ids).and_return(local_categories_ids) }

    let(:eve_category) { instance_double(Eve::Category) }

    before { expect(Eve::Category).to receive(:find_or_initialize_by).with(id: local_category_id).and_return(eve_category) }

    before { expect(eve_category).to receive(:destroy!) }

    specify { expect { subject.send(:remove_old_categories) }.not_to raise_error }
  end
end
