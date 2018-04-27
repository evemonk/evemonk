# frozen_string_literal: true

require 'rails_helper'

describe EveRacesWorker do
  it { should be_an(Sidekiq::Worker) }

  describe '#perform' do
    before do
      #
      # RacesImporter.new.import
      #
      expect(RacesImporter).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform }.not_to raise_error }
  end
end
