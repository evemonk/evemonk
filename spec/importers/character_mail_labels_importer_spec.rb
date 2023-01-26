# frozen_string_literal: true

require "rails_helper"

describe CharacterMailLabelsImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#import!" do
    let(:character) { instance_double(Character) }

    before { expect(subject).to receive(:character).and_return(character).exactly(3).times }

    let(:total_unread_count) { double }

    let(:json) { double }

    let(:label) do
      instance_double(EveOnline::ESI::Models::MailLabel,
        as_json: json)
    end

    let(:esi) do
      instance_double(EveOnline::ESI::CharacterMailLabels,
        labels: [label],
        total_unread_count: total_unread_count)
    end

    before { expect(subject).to receive(:esi).and_return(esi).twice }

    before do
      #
      # character.character_mail_labels.destroy_all
      #
      expect(character).to receive(:character_mail_labels) do
        double.tap do |a|
          expect(a).to receive(:destroy_all)
        end
      end
    end

    before { expect(character).to receive(:update!).with(total_unread_count: total_unread_count) }

    before do
      #
      # character.character_mail_labels.create!(label.as_json)
      #
      expect(character).to receive(:character_mail_labels) do
        double.tap do |a|
          expect(a).to receive(:create!).with(json)
        end
      end
    end

    specify { expect { subject.import! }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterMailLabels) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterMailLabels) }

      let(:character) { instance_double(Character, character_id: character_id) }

      before { expect(subject).to receive(:character).and_return(character) }

      before { expect(EveOnline::ESI::CharacterMailLabels).to receive(:new).with(character_id: character_id).and_return(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
