# frozen_string_literal: true

require "rails_helper"

describe Sde::UnitsImporter do
  let(:file) { double }

  subject { described_class.new(file) }

  describe "#initialize" do
    its(:file) { should eq(file) }
  end

  describe "#import" do
    let(:content) { double }

    before { expect(File).to receive(:read).with(file).and_return(content) }

    let(:unit_id) { double }

    let(:unit_name) { double }

    let(:description) { double }

    let(:display_name) { double }

    let(:entry) do
      {
        "unitID" => unit_id,
        "unitName" => unit_name,
        "description" => description,
        "displayName" => display_name
      }
    end

    let(:entries) { [entry] }

    before { expect(YAML).to receive(:safe_load).with(content).and_return(entries) }

    let(:eve_unit) { instance_double(Eve::Unit) }

    before { expect(Eve::Unit).to receive(:find_or_initialize_by).with({id: unit_id}).and_return(eve_unit) }

    before do
      expect(eve_unit).to receive(:assign_attributes).with({
        unit_name: unit_name,
        description: description,
        display_name: display_name
      })
    end

    before { expect(eve_unit).to receive(:save!) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
