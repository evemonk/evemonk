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

    let(:eve_type) { instance_double(Eve::Type) }

    before { expect(Eve::Type).to receive(:find_or_initialize_by).with({type_id: key}).and_return(eve_type) }

    before { expect(eve_type).to receive(:transaction).and_yield }

    before do
      expect(eve_type).to receive(:assign_attributes).with({
        copying_time: copying_time,
        manufacturing_time: manufacturing_time,
        research_material_time: research_material_time,
        research_time_time: research_time_time,
        invention_time: invention_time,
        max_production_limit: max_production_limit,
        is_blueprint: true
      })
    end

    before { expect(eve_type).to receive(:save!) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
