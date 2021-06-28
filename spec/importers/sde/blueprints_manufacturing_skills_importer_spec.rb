# frozen_string_literal: true

require "rails_helper"

describe Sde::BlueprintsManufacturingSkillsImporter do
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
      # eve_blueprint.blueprint_manufacturing_skills.destroy_all
      #
      expect(eve_blueprint).to receive(:blueprint_manufacturing_skills) do
        double.tap do |a|
          expect(a).to receive(:destroy_all)
        end
      end
    end

    before { expect(eve_blueprint).to receive(:save!) }

    context "when blueprint manufacturing skills present" do
      let(:level) { double }

      let(:entry) do
        {
          "activities" => {
            "manufacturing" => {
              "skills" => [
                {
                  "level" => level,
                  "typeID" => type_id
                }
              ]
            }
          }
        }
      end

      before do
        #
        # Eve::BlueprintManufacturingSkill.create!(blueprint_id: eve_blueprint.type_id,
        #                                          level: manufacturing_skill["level"],
        #                                          type_id: manufacturing_skill["typeID"])
        #
        expect(Eve::BlueprintManufacturingSkill).to receive(:create!).with(blueprint_id: type_id,
          level: level,
          type_id: type_id)
      end

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when blueprint manufacturing skills not present" do
      let(:entry) { {} }

      before { expect(Eve::BlueprintManufacturingSkill).not_to receive(:create!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
