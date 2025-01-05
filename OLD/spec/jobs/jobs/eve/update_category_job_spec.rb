# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateCategoryJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:category_id) { double }

    before do
      #
      # LanguageMapper::LANGUAGES.each_key do |locale|
      #   Eve::CategoryImporter.new(category_id, locale).import
      # end
      #
      LanguageMapper::LANGUAGES.each_key do |locale|
        expect(Eve::CategoryImporter).to receive(:new).with(category_id, locale) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end
    end

    specify { expect { subject.perform(category_id) }.not_to raise_error }
  end
end
