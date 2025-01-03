# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::GroupImporter do
  let(:group_id) { 450 }

  subject { described_class.new(group_id) }

  it { expect(subject).to be_a(Eve::BaseImporter) }

  describe "#import" do
    context "with default locale" do
      before { VCR.insert_cassette "esi/universe/groups/450" }

      after { VCR.eject_cassette }

      specify { expect { subject.import }.to change(Eve::Group, :count).by(1) }

      specify do
        subject.import

        group = Eve::Group.first

        expect(group.id).to eq(450)

        expect(group.category_id).to eq(25)

        expect(group.name_en).to eq("Arkonor")
      end
    end

    context "with de locale" do
      before { VCR.insert_cassette "esi/universe/groups/450_de" }

      after { VCR.eject_cassette }

      subject { described_class.new(group_id, :de) }

      specify do
        subject.import

        group = Eve::Group.first

        expect(group.name_de).to eq("Arkonor")
      end
    end

    context "when group not found" do
      let(:group_id) { 9_999_999 }

      before { VCR.insert_cassette "esi/universe/groups/not_found" }

      after { VCR.eject_cassette }

      specify { expect { subject.import }.not_to change(Eve::Group, :count) }
    end
  end
end
