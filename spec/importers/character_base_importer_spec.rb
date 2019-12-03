# frozen_string_literal: true

require "rails_helper"

describe CharacterBaseImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  describe "#initialize" do
    its(:character_id) { should eq(character_id) }
  end

  describe "#import" do
    context "when everything ok" do
      before { expect(subject).to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when EveOnline::Exceptions::ResourceNotFound" do
      before { expect(subject).to receive(:update!).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      before do
        #
        # subject.character.destroy!
        #
        expect(subject).to receive(:character) do
          double.tap do |a|
            expect(a).to receive(:destroy!)
          end
        end
      end

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when ActiveRecord::RecordNotFound" do
      before { expect(subject).to receive(:update!).and_raise(ActiveRecord::RecordNotFound) }

      before do
        #
        # Rails.logger.info("Character with ID #{ character_id } not found")
        #
        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info).with("Character with ID #{character_id} not found")
          end
        end
      end

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  # TODO: more
end
