# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::CategoryImporter do
  let(:category_id) { double }

  subject { described_class.new(category_id) }

  it { expect(subject).to be_a(Eve::BaseImporter) }

  describe "#import" do
    context "when eve category found" do
      let(:category_id) { 20 }

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
  end

  # describe "#import" do
  #   before { expect(subject).to receive(:configure_middlewares) }
  #
  #   let(:eve_category) { instance_double(Eve::Category) }
  #
  #   before { expect(Eve::Category).to receive(:find_or_initialize_by).with(id: category_id).and_return(eve_category) }
  #
  #   context "when eve category not found" do
  #     before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }
  #
  #     before do
  #       #
  #       # Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Category ID #{category_id}")
  #
  #       expect(Rails).to receive(:logger) do
  #         double.tap do |a|
  #           expect(a).to receive(:info).with("EveOnline::Exceptions::ResourceNotFound: Eve Category ID #{category_id}")
  #         end
  #       end
  #     end
  #
  #     before { expect(eve_category).to receive(:destroy!) }
  #
  #     specify { expect { subject.import }.not_to raise_error }
  #   end
  # end
end
