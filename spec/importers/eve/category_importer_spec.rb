# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::CategoryImporter do
  let(:category_id) { 20 }

  subject { described_class.new(category_id) }

  it { expect(subject).to be_a(Eve::BaseImporter) }

  describe "#import" do
    context "when eve category found" do
      let(:category_id) { 20 }

      context "with default locale" do
        before { VCR.insert_cassette "esi/universe/categories/20" }

        after { VCR.eject_cassette }

        specify { expect { subject.import }.to change(Eve::Category, :count).by(1) }

        specify do
          subject.import

          category = Eve::Category.first

          expect(category.id).to eq(20)

          expect(category.name_en).to eq("Implant")

          expect(category.published).to eq(true)
        end
      end

      context "with de locale" do
        let(:locale) { :de }

        subject { described_class.new(category_id, locale) }

        before { VCR.insert_cassette "esi/universe/categories/20_de" }

        after { VCR.eject_cassette }

        specify do
          subject.import

          category = Eve::Category.first

          expect(category.name_de).to eq("Implantat")
        end
      end
    end

    context "when eve category not found" do
      let(:category_id) { 9_999_999 }

      before { VCR.insert_cassette "esi/universe/categories/not_found" }

      after { VCR.eject_cassette }

      specify { expect { subject.import }.not_to change(Eve::Category, :count) }
    end
  end
end
