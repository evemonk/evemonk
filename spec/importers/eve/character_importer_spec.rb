# frozen_string_literal: true

require "rails_helper"

describe Eve::CharacterImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(Eve::BaseImporter) }

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    before { expect(subject).to receive(:configure_etag) }

    let(:eve_character) { instance_double(Eve::Character) }

    before { expect(Eve::Character).to receive(:find_or_initialize_by).with(character_id: character_id).and_return(eve_character) }

    context "when etag cache hit" do
      let(:esi) { instance_double(EveOnline::ESI::Character, not_modified?: true) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when etag cache miss" do
      context "when eve character found" do
        let(:json) { double }

        let(:esi) { instance_double(EveOnline::ESI::Character, not_modified?: false, as_json: json) }

        before { expect(subject).to receive(:esi).and_return(esi).twice }

        before { expect(eve_character).to receive(:update!).with(json) }

        before { expect(subject).to receive(:update_etag) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when eve character not found" do
        before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }

        let(:eve_etag) { instance_double(Eve::Etag) }

        before { expect(subject).to receive(:etag).and_return(eve_etag) }

        before do
          #
          # Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Character ID #{character_id}")

          expect(Rails).to receive(:logger) do
            double.tap do |a|
              expect(a).to receive(:info).with("EveOnline::Exceptions::ResourceNotFound: Eve Character ID #{character_id}")
            end
          end
        end

        before { expect(eve_etag).to receive(:destroy!) }

        before { expect(eve_character).to receive(:destroy!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::Character) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::Character) }

      before { expect(EveOnline::ESI::Character).to receive(:new).with(character_id: character_id).and_return(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
