# frozen_string_literal: true

require "rails_helper"

describe Eve::CharacterPortraitImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(Eve::BaseImporter) }

  specify { expect(described_class::PORTRAIT_URL).to eq("https://images.evetech.net/characters/%s/portrait") }

  describe "#import" do
    let(:character_id) { 1_337_512_245 }

    let(:eve_character) { instance_double(Eve::Character) }

    before { expect(Eve::Character).to receive(:find_or_initialize_by).with(character_id: character_id).and_return(eve_character) }

    # eve_character = Eve::Character.find_or_initialize_by(character_id: character_id)
    #
    # tempfile = Down.download(PORTRAIT_URL % character_id)
    #
    # eve_character.portrait.attach(io: tempfile, filename: "#{character_id}.jpg")
    #
    # eve_character.save!

    before { expect(eve_character).to receive(:save!) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
