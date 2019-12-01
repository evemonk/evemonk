# frozen_string_literal: true

require "rails_helper"

describe UpdateCharactersJob do
  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:character_id) { double }

    before do
      #
      # Character.pluck(:character_id).sort.uniq.each do |character_id|
      #   UpdateCharacterInfoService.new(character_id).execute
      # end
      #
      expect(Character).to receive(:pluck).with(:character_id) do
        double.tap do |a|
          expect(a).to receive(:sort) do
            double.tap do |b|
              expect(b).to receive(:uniq).and_return([character_id])
            end
          end
        end
      end
    end

    before do
      #
      # UpdateCharacterInfoService.new(character_id).execute
      #
      expect(UpdateCharacterInfoService).to receive(:new).with(character_id) do
        double.tap do |a|
          expect(a).to receive(:execute)
        end
      end
    end

    specify { expect { subject.perform }.not_to raise_error }
  end
end
