# frozen_string_literal: true

require "rails_helper"

describe Eve::CharacterPortraitImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(Eve::BaseImporter) }

  describe "#import" do
    specify { expect { subject.import }.not_to raise_error }
  end
end
