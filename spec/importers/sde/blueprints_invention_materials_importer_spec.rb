# frozen_string_literal: true

require "rails_helper"

describe Sde::BlueprintsInventionMaterialsImporter do
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

    let(:eve_blueprint) { instance_double(Eve::Blueprint) }

    before { expect(Eve::Blueprint).to receive(:find).with(key).and_return(eve_blueprint) }

    before { expect(eve_blueprint).to receive(:transaction).and_yield }

    before do
      #
      # eve_blueprint.blueprint_invention_materials.destroy_all
      #
      expect(eve_blueprint).to receive(:blueprint_invention_materials) do
        double.tap do |a|
          expect(a).to receive(:destroy_all)
        end
      end
    end

    before { expect(eve_blueprint).to receive(:save!) }

    context "when blueprint invention materials present" do
      let(:quantity) { double }

      let(:entry) do
        {
          "activities" => {
            "invention" => {
              "materials" => [
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
        # Eve::BlueprintInventionMaterial.create!(blueprint: eve_blueprint,
        #                                         quantity: invention_material["quantity"],
        #                                         type_id: invention_material["typeID"])
        #
        expect(Eve::BlueprintInventionMaterial).to receive(:create!).with(blueprint: eve_blueprint,
          quantity: quantity,
          type_id: type_id)
      end

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when blueprint invention materials not present" do
      let(:entry) { {} }

      before { expect(Eve::BlueprintInventionMaterial).not_to receive(:create!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
