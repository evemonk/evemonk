# frozen_string_literal: true

require "rails_helper"

describe Sde::BlueprintsInventionProductsImporter do
  let(:file) { double }

  subject { described_class.new(file) }

  describe "#initialize" do
    its(:file) { should eq(file) }
  end

  describe "#import" do
    let(:content) { double }

    before { expect(File).to receive(:read).with(file).and_return(content) }

    let(:key) { double }

    let(:type_id) { double }

    let(:entries) { {key => entry} }

    before { expect(YAML).to receive(:safe_load).with(content).and_return(entries) }

    let(:eve_blueprint) { instance_double(Eve::Blueprint, type_id: type_id) }

    before { expect(Eve::Blueprint).to receive(:find_by!).with(type_id: key).and_return(eve_blueprint) }

    before { expect(eve_blueprint).to receive(:transaction).and_yield }

    before do
      #
      # eve_blueprint.blueprint_invention_products.destroy_all
      #
      expect(eve_blueprint).to receive(:blueprint_invention_products) do
        double.tap do |a|
          expect(a).to receive(:destroy_all)
        end
      end
    end

    before { expect(eve_blueprint).to receive(:save!) }

    context "when blueprint invention products present" do
      let(:quantity) { double }

      let(:probability) { double }

      let(:entry) do
        {
          "activities" => {
            "invention" => {
              "products" => [
                {
                  "quantity" => quantity,
                  "typeID" => type_id,
                  "probability" => probability
                }
              ]
            }
          }
        }
      end

      before do
        #
        # Eve::BlueprintInventionProduct.create!(blueprint_id: eve_blueprint.type_id,
        #                                        probability: invention_product["probability"],
        #                                        quantity: invention_product["quantity"],
        #                                        type_id: type_id)
        #
        expect(Eve::BlueprintInventionProduct).to receive(:create!).with(blueprint_id: type_id,
          probability: probability,
          quantity: quantity,
          type_id: type_id)
      end

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when blueprint invention products not present" do
      let(:entry) { {} }

      before { expect(Eve::BlueprintInventionProduct).not_to receive(:create!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
