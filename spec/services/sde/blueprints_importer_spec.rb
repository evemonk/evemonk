# frozen_string_literal: true

require "rails_helper"

describe Sde::BlueprintsImporter do
  let(:file) { double }

  subject { described_class.new(file) }

  describe "#initialize" do
    its(:file) { should eq(file) }
  end

  describe "#import" do
    let(:content) { double }

    before { expect(File).to receive(:read).with(file).and_return(content) }

    let(:key) { double }

    let(:copying_time) { double }

    let(:manufacturing_time) { double }

    let(:research_material_time) { double }

    let(:research_time_time) { double }

    let(:invention_time) { double }

    let(:max_production_limit) { double }

    let(:entry) do
      {
        "activities" => {
          "copying" => {
            "time" => copying_time
          },
          "manufacturing" => {
            "time" => manufacturing_time
          },
          "research_material" => {
            "time" => research_material_time
          },
          "research_time" => {
            "time" => research_time_time
          },
          "invention" => {
            "time" => invention_time
          }
        },
        "maxProductionLimit" => max_production_limit
      }
    end

    let(:entries) { {key => entry} }

    before { expect(YAML).to receive(:safe_load).with(content).and_return(entries) }

    let(:eve_blueprint) { instance_double(Eve::Blueprint) }

    before { expect(Eve::Blueprint).to receive(:find_or_initialize_by).with(type_id: key).and_return(eve_blueprint) }

    before { expect(eve_blueprint).to receive(:transaction).and_yield }

    before { expect(subject).to receive(:import_more_information).with(eve_blueprint, entry) }

    before { expect(eve_blueprint).to receive(:assign_attributes).with(copying_time: copying_time,
                                                                       manufacturing_time: manufacturing_time,
                                                                       research_material_time: research_material_time,
                                                                       research_time_time: research_time_time,
                                                                       invention_time: invention_time,
                                                                       max_production_limit: max_production_limit,
                                                                       is_blueprint: true) }

    before { expect(eve_blueprint).to receive(:save!) }

    specify { expect { subject.import }.not_to raise_error }
  end

  # private methods

  describe "#import_more_information" do
    let(:eve_blueprint) { double }

    let(:hash) { double }

    specify { expect { subject.send(:import_more_information, eve_blueprint, hash) }.not_to raise_error }
  end

  describe "#import_blueprint_invention_materials" do
    let(:eve_blueprint) { double }

    let(:hash) { double }

    specify { expect { subject.send(:import_blueprint_invention_materials, eve_blueprint, hash) }.not_to raise_error }
  end

  describe "#import_blueprint_invention_products" do
    let(:eve_blueprint) { double }

    let(:hash) { double }

    specify { expect { subject.send(:import_blueprint_invention_products, eve_blueprint, hash) }.not_to raise_error }
  end

  describe "#import_blueprint_invention_skills" do
    let(:eve_blueprint) { double }

    let(:hash) { double }

    specify { expect { subject.send(:import_blueprint_invention_skills, eve_blueprint, hash) }.not_to raise_error }
  end

  describe "#import_blueprint_manufacturing_materials" do
    let(:eve_blueprint) { double }

    let(:hash) { double }

    specify { expect { subject.send(:import_blueprint_manufacturing_materials, eve_blueprint, hash) }.not_to raise_error }
  end

  describe "#import_blueprint_manufacturing_products" do
    let(:eve_blueprint) { double }

    let(:hash) { double }

    specify { expect { subject.send(:import_blueprint_manufacturing_products, eve_blueprint, hash) }.not_to raise_error }
  end

  describe "#import_blueprint_manufacturing_skills" do
    let(:eve_blueprint) { double }

    let(:hash) { double }

    specify { expect { subject.send(:import_blueprint_manufacturing_skills, eve_blueprint, hash) }.not_to raise_error }
  end
end
