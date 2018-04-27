# frozen_string_literal: true

require 'rails_helper'

describe EveFactionsWorker do
  it { should be_an(Sidekiq::Worker) }

  describe '#perform' do
    before do
      #
      # FactionsImporter.new.import
      #
      expect(FactionsImporter).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform }.not_to raise_error }
  end
end
