# frozen_string_literal: true

require 'rails_helper'

describe EveAncestriesWorker do
  it { should be_an(Sidekiq::Worker) }

  describe '#perform' do
    before do
      #
      # AncestriesImporter.new.import
      #
      expect(AncestriesImporter).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform }.not_to raise_error }
  end
end
