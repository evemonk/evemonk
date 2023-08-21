# frozen_string_literal: true

require "rails_helper"

describe Sde::BasePricesImporter do
  let(:file) { double }

  subject { described_class.new(file) }

  describe "#initialize" do
    its(:file) { should eq(file) }
  end

  describe "#import" do
    let(:key) { double }

    let(:base_price) { double }

    let(:entry) do
      {
        "basePrice" => base_price
      }
    end

    let(:entries) { {key => entry} }

    before { expect(YAML).to receive(:safe_load_file).with(file).and_return(entries) }

    let(:eve_type) { instance_double(Eve::Type) }

    before { expect(Eve::Type).to receive(:find_or_initialize_by).with(type_id: key).and_return(eve_type) }

    before { expect(eve_type).to receive(:assign_attributes).with(base_price: base_price) }

    before { expect(eve_type).to receive(:save!) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
