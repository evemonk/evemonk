# frozen_string_literal: true

require "rails_helper"

describe Sde::IconsImporter do
  let(:file) { double }

  subject { described_class.new(file) }

  describe "#initialize" do
    its(:file) { should eq(file) }
  end

  describe "#import" do
    let(:content) { double }

    before { expect(File).to receive(:read).with(file).and_return(content) }

    let(:key) { double }

    let(:description) { double }

    let(:icon_file) { double }

    let(:obsolete) { double }

    let(:entry) do
      {
        "description" => description,
        "iconFile" => icon_file,
        "obsolete" => obsolete
      }
    end

    let(:entries) { {key => entry} }

    before { expect(YAML).to receive(:safe_load).with(content).and_return(entries) }

    let(:eve_icon) { instance_double(Eve::Icon) }

    before { expect(Eve::Icon).to receive(:find_or_initialize_by).with(id: key).and_return(eve_icon) }

    before do
      expect(eve_icon).to receive(:assign_attributes).with(description: description,
        icon_file: icon_file,
        obsolete: obsolete)
    end

    before { expect(eve_icon).to receive(:save!) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
