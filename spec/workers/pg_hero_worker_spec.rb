# frozen_string_literal: true

require 'rails_helper'

describe PgHeroWorker do
  it { should be_a(Sidekiq::Worker) }

  describe '#perform' do
    before { expect(PgHero).to receive(:capture_query_stats) }

    specify { expect { subject.perform }.not_to raise_error }
  end
end
