# frozen_string_literal: true

require "rails_helper"

describe CharacterMailLabelsImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#update!" do
    context "when scope present" do
      before { expect(subject).to receive(:refresh_character_access_token) }

      let(:access_token) { double }

      let(:character) do
        instance_double(Character,
          character_id: character_id,
          access_token: access_token,
          scopes: "esi-mail.read_mail.v1")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(6).times }

      let(:total_unread_count) { double }

      let(:json) { double }

      let(:label) do
        instance_double(EveOnline::ESI::Models::MailLabel,
          as_json: json)
      end

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterMailLabels,
          labels: [label],
          total_unread_count: total_unread_count,
          scope: "esi-mail.read_mail.v1")
      end

      before { expect(EveOnline::ESI::CharacterMailLabels).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

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

      specify { expect { subject.update! }.not_to raise_error }
    end

    context "when scope not present" do
      before { expect(subject).to receive(:refresh_character_access_token) }

      let(:access_token) { double }

      let(:character) do
        instance_double(Character,
          character_id: character_id,
          access_token: access_token,
          scopes: "")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(3).times }

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterMailLabels,
          scope: "esi-mail.read_mail.v1")
      end

      before { expect(EveOnline::ESI::CharacterMailLabels).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

      before { expect(character).not_to receive(:update!) }

      before { expect(character).not_to receive(:character_mail_labels) }

      specify { expect { subject.update! }.not_to raise_error }
    end
  end
end
