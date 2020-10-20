# frozen_string_literal: true

require "rails_helper"

describe CharacterOnlineImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#import!" do
    let(:online) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::CharacterOnline,
        online: online)
    end

    let(:character) { instance_double(Character) }

    before { expect(subject).to receive(:character).and_return(character) }

    before { expect(subject).to receive(:esi).and_return(esi) }

    before { expect(character).to receive(:update!).with(online: online) }

    specify { expect { subject.import! }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterOnline) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterOnline) }

      let(:character) { instance_double(Character, character_id: character_id) }

      before { expect(subject).to receive(:character).and_return(character) }

      before { expect(EveOnline::ESI::CharacterOnline).to receive(:new).with(character_id: character_id).and_return(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
