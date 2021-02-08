# frozen_string_literal: true

require "rails_helper"

describe Sde::CertificatesImporter do
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

    let(:group_id) { double }

    let(:name) { double }

    let(:entry) do
      {
        "description" => description,
        "groupID" => group_id,
        "name" => name
      }
    end

    let(:entries) { {key => entry} }

    before { expect(YAML).to receive(:safe_load).with(content).and_return(entries) }

    let(:eve_certificate) { instance_double(Eve::Certificate) }

    before { expect(Eve::Certificate).to receive(:find_or_initialize_by).with(certificate_id: key).and_return(eve_certificate) }

    before do
      #
      # eve_certificate.certificate_recommended_types.destroy_all
      #
      expect(eve_certificate).to receive(:certificate_recommended_types) do
        double.tap do |a|
          expect(a).to receive(:destroy_all)
        end
      end
    end

    before do
      expect(eve_certificate).to receive(:assign_attributes).with(description: description,
                                                                  group_id: group_id,
                                                                  name: name)
    end

    before { expect(eve_certificate).to receive(:save!) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
