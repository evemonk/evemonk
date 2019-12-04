# frozen_string_literal: true

require "rails_helper"

describe CharacterLoyaltyPointsImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#update!" do
    context "when scope present" do
      before { expect(subject).to receive(:refresh_character_access_token) }

      let(:access_token) { double }

      let(:character) do
        instance_double(Character,
          character_id: character_id,
          access_token: access_token,
          scopes: "esi-characters.read_loyalty.v1")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(5).times }

      let(:json) { double }

      let(:corporation_id) { double }

      let(:lp) do
        instance_double(EveOnline::ESI::Models::LoyaltyPoint,
          corporation_id: corporation_id,
          as_json: json)
      end

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterLoyaltyPoints,
          loyalty_points: [lp],
          scope: "esi-characters.read_loyalty.v1")
      end

      before { expect(EveOnline::ESI::CharacterLoyaltyPoints).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

      before do
        #
        # character.loyalty_points.destroy_all
        #
        expect(character).to receive(:loyalty_points) do
          double.tap do |a|
            expect(a).to receive(:destroy_all)
          end
        end
      end

      let(:loyalty_point) { instance_double(LoyaltyPoint) }

      before do
        #
        # character.loyalty_points.find_or_initialize_by(corporation_id: lp.corporation_id)
        #
        expect(character).to receive(:loyalty_points) do
          double.tap do |a|
            expect(a).to receive(:find_or_initialize_by).with(corporation_id: corporation_id)
              .and_return(loyalty_point)
          end
        end
      end

      before { expect(loyalty_point).to receive(:assign_attributes).with(json) }

      before { expect(loyalty_point).to receive(:save!) }

      specify { expect { subject.update! }.not_to raise_error }
    end

    context "when scope not present" do
      before { expect(subject).to receive(:refresh_character_access_token) }

      let(:access_token) { double }

      let(:character) do
        instance_double(Character,
          character_id: character_id,
          access_token: access_token,
          scopes: "")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(3).times }

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterLoyaltyPoints,
          scope: "esi-characters.read_loyalty.v1")
      end

      before { expect(EveOnline::ESI::CharacterLoyaltyPoints).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

      before { expect(character).not_to receive(:loyalty_points) }

      specify { expect { subject.update! }.not_to raise_error }
    end
  end
end
