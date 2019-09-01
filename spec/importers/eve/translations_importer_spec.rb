# frozen_string_literal: true

require "rails_helper"

describe Eve::TranslationsImporter do
  describe "#import" do
    before { expect(subject).to receive(:update_eve_races).with(:de) }

    before { expect(subject).to receive(:update_eve_races).with(:fr) }

    before { expect(subject).to receive(:update_eve_races).with(:ja) }

    before { expect(subject).to receive(:update_eve_races).with(:ru) }

    before { expect(subject).to receive(:update_eve_races).with(:zh) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
