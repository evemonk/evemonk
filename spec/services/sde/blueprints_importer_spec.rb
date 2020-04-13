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

    let(:entry) do
      {
        "activities" => { "copying" => { "time" => copying_time } }
      }
    end

    let(:entries) { {key => entry} }

    before { expect(YAML).to receive(:safe_load).with(content).and_return(entries) }

    let(:eve_blueprint) { instance_double(Eve::Blueprint) }

    before { expect(Eve::Blueprint).to receive(:find_or_initialize_by).with(type_id: key).and_return(eve_blueprint) }

    before { expect(eve_blueprint).to receive(:transaction).and_yield }

    before { expect(eve_blueprint).to receive(:assign_attributes).with(copying_time: copying_time,
                                                                       is_blueprint: true) }

    before { expect(eve_blueprint).to receive(:save!) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
