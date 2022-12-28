# frozen_string_literal: true

require "rails_helper"

describe Sde::BlueprintsManufacturingProductsImporter do
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

    before { expect(Eve::Blueprint).to receive(:find_by!).with({type_id: key}).and_return(eve_blueprint) }

    before { expect(eve_blueprint).to receive(:transaction).and_yield }

    before do
      #
      # eve_blueprint.blueprint_manufacturing_products.destroy_all
      #
      expect(eve_blueprint).to receive(:blueprint_manufacturing_products) do
        double.tap do |a|
          expect(a).to receive(:destroy_all)
        end
      end
    end

    before { expect(eve_blueprint).to receive(:save!) }

    context "when blueprint manufacturing products present" do
      let(:quantity) { double }

      let(:entry) do
        {
          "activities" => {
            "manufacturing" => {
              "products" => [
                {
                  "quantity" => quantity,
                  "typeID" => type_id
                }
              ]
            }
          }
        }
      end

      before do
        #
        # Eve::BlueprintManufacturingProduct.create!(blueprint_id: eve_blueprint.type_id,
        #                                            quantity: manufacturing_product["quantity"],
        #                                            type_id: manufacturing_product["typeID"])
        #
        expect(Eve::BlueprintManufacturingProduct).to receive(:create!).with({
          blueprint_id: type_id,
          quantity: quantity,
          type_id: type_id
        })
      end

      let(:eve_type) { instance_double(Eve::Type) }

      before { expect(Eve::Type).to receive(:find_or_initialize_by).with({type_id: type_id}).and_return(eve_type) }

      before { expect(eve_type).to receive(:update!).with({is_manufacturing_item: true}) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when blueprint manufacturing products not present" do
      let(:entry) { {} }

      before { expect(Eve::BlueprintManufacturingProduct).not_to receive(:create!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
