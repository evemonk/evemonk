# frozen_string_literal: true

require "rails_helper"

describe Eve::CharacterPortraitImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(Eve::BaseImporter) }

  specify { expect(described_class::PORTRAIT_URL).to eq("https://images.evetech.net/characters/%s/portrait") }

  describe "#import" do
    let(:character_id) { 1_337_512_245 }

    let(:portrait) { instance_double(ActiveStorage::Attached::One) }

    let(:eve_character) { instance_double(Eve::Character, portrait: portrait) }

    before do
      expect(Eve::Character).to receive(:find_or_initialize_by)
        .with(character_id: character_id)
        .and_return(eve_character)
    end

    let(:tempfile) { instance_double(Tempfile) }

    before do
      expect(Down).to receive(:download)
        .with("https://images.evetech.net/characters/1337512245/portrait")
        .and_return(tempfile)
    end

    before do
      expect(portrait).to receive(:attach)
        .with(io: tempfile, filename: "1337512245.jpg")
    end

    before { expect(eve_character).to receive(:save!) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
