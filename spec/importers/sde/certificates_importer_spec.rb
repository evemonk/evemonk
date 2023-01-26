# frozen_string_literal: true

require "rails_helper"

describe Sde::CertificatesImporter do
  let(:file) { double }

  subject { described_class.new(file) }

  specify do
    expect(described_class::LEVELS).to eq(
      "basic" => 1,
      "standard" => 2,
      "improved" => 3,
      "advanced" => 4,
      "elite" => 5
    )
  end

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

    let(:type_id) { 123 }

    let(:level) { "advanced" }

    let(:skill_level) { 5 }

    let(:entry) do
      {
        "description" => description,
        "groupID" => group_id,
        "name" => name,
        "recommendedFor" => [123_456],
        "skillTypes" => {
          type_id => {
            level => skill_level
          }
        }
      }
    end

    let(:entries) { {key => entry} }

    before { expect(YAML).to receive(:safe_load).with(content).and_return(entries) }

    let(:eve_certificate) { instance_double(Eve::Certificate) }

    before { expect(Eve::Certificate).to receive(:find_or_initialize_by).with(id: key).and_return(eve_certificate) }

    before do
      expect(eve_certificate).to receive(:assign_attributes).with(description: description,
        group_id: group_id,
        name: name)
    end

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
      #
      # eve_certificate.certificate_recommended_types.build(type_id: recommended_type_id)
      #
      expect(eve_certificate).to receive(:certificate_recommended_types) do
        double.tap do |a|
          expect(a).to receive(:build).with(type_id: 123_456)
        end
      end
    end

    before do
      #
      # eve_certificate.certificate_skills.destroy_all
      #
      expect(eve_certificate).to receive(:certificate_skills) do
        double.tap do |a|
          expect(a).to receive(:destroy_all)
        end
      end
    end

    before do
      #
      # eve_certificate.certificate_skills.build(type_id: type_id,
      #                                          level: LEVELS.fetch(key),
      #                                          skill_level: value)
      #
      expect(eve_certificate).to receive(:certificate_skills) do
        double.tap do |a|
          expect(a).to receive(:build).with(type_id: type_id,
            level: described_class::LEVELS.fetch(level),
            skill_level: skill_level)
        end
      end
    end

    before { expect(eve_certificate).to receive(:save!) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
