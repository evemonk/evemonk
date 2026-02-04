# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::CharacterImporter do
  let(:id) { 1 }

  subject { described_class.new(id) }

  it { expect(subject).to be_a(Eve::BaseImporter) }

  describe "#import" do
    context "when eve character is exist" do
      let(:id) { 90_729_314 }

      before { VCR.insert_cassette "esi/characters/90729314" }

      after { VCR.eject_cassette }

      context "when character is present in db" do
        let!(:eve_character) { create(:eve_character, id: id, name: nil) }

        specify { expect { subject.import }.not_to change(Eve::Character, :count) }

        specify { expect { subject.import }.to change { Eve::Character.first&.name }.from(nil).to("Green Black") }
      end

      context "when character is not present in db" do
        specify { expect { subject.import }.to change(Eve::Character, :count).by(1) }

        specify do
          expect { subject.import }
            .to change { Eve::Character.first&.attributes&.except("created_at", "updated_at") }
            .from(nil)
            .to(
              {
                "id" => 90_729_314,
                "alliance_id" => nil,
                "birthday" => Time.utc(2011, 5, 10, 10, 23, 0),
                "bloodline_id" => 7,
                "corporation_id" => 1_000_168,
                "description" => "",
                "faction_id" => nil,
                "gender" => "male",
                "name" => "Green Black",
                "race_id" => 8,
                "security_status" => 0.0,
                "title" => nil
              }
            )
        end
      end
    end

    context "when eve character is not exist" do
      let(:id) { 93_002_807 }

      before { VCR.insert_cassette "esi/characters/93002807" }

      after { VCR.eject_cassette }

      context "when character is present in db" do
        let!(:eve_character) { create(:eve_character, id: id) }

        specify { expect { subject.import }.to change(Eve::Character, :count).by(-1) }
      end

      context "when character is not present in db" do
        specify { expect { subject.import }.not_to change(Eve::Character, :count) }

        specify { expect { subject.import }.to change(Eve::DeletedCharacter, :count).by(1) }

        specify { expect { subject.import }.to change { Eve::DeletedCharacter.first&.id }.from(nil).to(id) }
      end

      context "when character is already blacklisted" do
        let!(:eve_deleted_character) do
          travel_to 1.day.ago do
            create(:eve_deleted_character, id: id)
          end
        end

        specify { expect { subject.import }.to(change { Eve::DeletedCharacter.last!.reload.updated_at }) }
      end
    end
  end
end
