# frozen_string_literal: true

require "rails_helper"

describe UpdateCharactersJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("important") }

  describe "#perform" do
    context "when update_characters_job enabled" do
      before { Flipper.enable(:update_characters_job) }

      let(:character_id) { double }

      before do
        #
        # Character.with_valid_tokens.pluck(:character_id).sort.uniq.each do |character_id|
        #   UpdateCharacterInfoService.new(character_id).execute
        # end
        #
        expect(Character).to receive(:with_valid_tokens) do
          double.tap do |a|
            expect(a).to receive(:pluck).with(:character_id) do
              double.tap do |b|
                expect(b).to receive(:sort) do
                  double.tap do |c|
                    expect(c).to receive(:uniq).and_return([character_id])
                  end
                end
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

      # before do
      #   #
      #   # Eve::UpdateMarketPricesJob.perform_later
      #   #
      #   expect(Eve::UpdateMarketPricesJob).to receive(:perform_later)
      # end

      before do
        #
        # ImportMissingJob.perform_later
        #
        expect(ImportMissingJob).to receive(:perform_later)
      end

      specify { expect { subject.perform }.not_to raise_error }
    end

    context "when update_characters_job disabled" do
      before { Flipper.disable(:update_characters_job) }

      before { expect(Character).not_to receive(:with_valid_tokens) }

      before { expect(UpdateCharacterInfoService).not_to receive(:new) }

      before { expect(ImportMissingJob).not_to receive(:perform_later) }

      specify { expect { subject.perform }.not_to raise_error }
    end
  end
end
