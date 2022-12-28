# frozen_string_literal: true

require "rails_helper"

describe Sde::BlueprintsInventionSkillsImporter do
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
      # eve_blueprint.blueprint_invention_skills.destroy_all
      #
      expect(eve_blueprint).to receive(:blueprint_invention_skills) do
        double.tap do |a|
          expect(a).to receive(:destroy_all)
        end
      end
    end

    before { expect(eve_blueprint).to receive(:save!) }

    context "when blueprint invention skills present" do
      let(:level) { double }

      let(:entry) do
        {
          "activities" => {
            "invention" => {
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
        # Eve::BlueprintInventionSkill.create!(blueprint_id: eve_blueprint.type_id,
        #                                      level: invention_skill["level"],
        #                                      type_id: invention_skill["typeID"])
        #
        expect(Eve::BlueprintInventionSkill).to receive(:create!).with({
          blueprint_id: type_id,
          level: level,
          type_id: type_id
        })
      end

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when blueprint invention skills not present" do
      let(:entry) { {} }

      before { expect(Eve::BlueprintInventionSkill).not_to receive(:create!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
