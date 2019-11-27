# frozen_string_literal: true

require "rails_helper"

describe Api::UpdateCharacterInfo do
  describe "#initialize" do
    let(:character) { instance_double(Character) }

    subject { described_class.new(character) }

    its(:character) { should eq(character) }
  end

  describe "#update!" do
    let(:character) { instance_double(Character) }

    subject(:service) { described_class.new(character) }

    before { expect(service).to receive(:character_loyalty_points) }

    specify { expect { service.update! }.not_to raise_error }
  end

  # private methods

  describe "#character_loyalty_points" do
    let(:character_id) { double }

    let(:access_token) { double }

    let(:character) { instance_double(Character, character_id: character_id, access_token: access_token) }

    subject(:service) { described_class.new(character) }

    let(:corporation_id) { double }

    let(:as_json) { double }

    let(:loyalty_point) { instance_double(EveOnline::ESI::Models::LoyaltyPoint, corporation_id: corporation_id, as_json: as_json) }

    let(:esi) { instance_double(EveOnline::ESI::CharacterLoyaltyPoints, loyalty_points: [loyalty_point]) }

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

    let(:character_loyalty_point) { instance_double(LoyaltyPoint) }

    before do
      #
      # character.loyalty_points.find_or_initialize_by(corporation_id: lp.corporation_id)
      #
      expect(character).to receive(:loyalty_points) do
        double.tap do |a|
          expect(a).to receive(:find_or_initialize_by)
            .with(corporation_id: corporation_id)
            .and_return(character_loyalty_point)
        end
      end
    end

    before { expect(character_loyalty_point).to receive(:assign_attributes).with(as_json) }

    before { expect(character_loyalty_point).to receive(:save!) }

    specify { expect { service.send(:character_loyalty_points) }.not_to raise_error }
  end
end
