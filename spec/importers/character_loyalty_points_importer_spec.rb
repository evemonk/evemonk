# frozen_string_literal: true

require "rails_helper"

describe CharacterLoyaltyPointsImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#import!" do
    let(:character) { instance_double(Character) }

    before { expect(subject).to receive(:character).and_return(character).twice }

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

    before { expect(subject).to receive(:esi).and_return(esi) }

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

    specify { expect { subject.import! }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterLoyaltyPoints) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterLoyaltyPoints) }

      let(:character) { instance_double(Character, character_id: character_id) }

      before { expect(subject).to receive(:character).and_return(character) }

      before { expect(EveOnline::ESI::CharacterLoyaltyPoints).to receive(:new).with(character_id: character_id).and_return(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
