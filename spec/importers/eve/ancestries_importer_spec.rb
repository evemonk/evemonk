# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::AncestriesImporter do
  it { expect(subject).to be_a(Eve::BaseImporter) }

  describe "#import" do
    context "with default locale" do
      before { VCR.insert_cassette "esi/universe/ancestries" }

      after { VCR.eject_cassette }

      specify { expect { subject.import }.to change(Eve::Ancestry, :count).by(43) }

      specify do
        subject.import

        ancestry = Eve::Ancestry.first

        expect(ancestry.id).to eq(1)

        expect(ancestry.bloodline_id).to eq(5)

        expect(ancestry.description_en).to start_with("Holders, the major landholding class in Amarr society, are generally conservative traditionalists.")

        expect(ancestry.icon_id).to eq(1641)

        expect(ancestry.name_en).to eq("Liberal Holders")

        expect(ancestry.short_description).to eq("Progressive members of the upper class who have rejected their traditional ways.")
      end
    end

    context "with de locale" do
      before { VCR.insert_cassette "esi/universe/ancestries_de" }

      after { VCR.eject_cassette }

      subject { described_class.new(:de) }

      specify do
        subject.import

        ancestry = Eve::Ancestry.first

        expect(ancestry.name_de).to eq("Liberale Großgrundbesitzer")

        expect(ancestry.description_de).to start_with("Die meisten Ländereien Amarrs gehören den Großgrundbesitzern, die üblicherweise erzkonservativ sind und die Tradition hochhalten.")
      end
    end
  end
end
