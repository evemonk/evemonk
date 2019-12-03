# frozen_string_literal: true

require "rails_helper"

describe CharacterLoyaltyPointsImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  context "when character found" do
    let(:access_token) { double }

    let(:character) { instance_double(Character, access_token: access_token) }

    before { expect(Character).to receive(:find_by!).with(character_id: character_id).and_return(character) }

    before { expect(subject).to receive(:refresh_character_access_token) }

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

    let(:json) { double }

    let(:corporation_id) { double }

    let(:lp) do
      instance_double(EveOnline::ESI::Models::LoyaltyPoint,
        corporation_id: corporation_id,
        as_json: json)
    end

    let(:esi) do
      instance_double(EveOnline::ESI::CharacterLoyaltyPoints,
        loyalty_points: [lp])
    end

    before { expect(EveOnline::ESI::CharacterLoyaltyPoints).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

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

    specify { expect { subject.import }.not_to raise_error }
  end

  context "when character not found (ActiveRecord::RecordNotFound)" do
    before { expect(Character).to receive(:find_by!).with(character_id: character_id).and_raise(ActiveRecord::RecordNotFound) }

    before do
      #
      # Rails.logger.info("Character with ID #{ character_id } not found")
      #
      expect(Rails).to receive(:logger) do
        double.tap do |a|
          expect(a).to receive(:info).with("Character with ID #{character_id} not found")
        end
      end
    end

    specify { expect { subject.import }.not_to raise_error }
  end
end
