# frozen_string_literal: true

require "rails_helper"

describe Eve::CharacterImporter do
  describe "#import" do
    context "when fresh data available" do
      context "when character found" do
        let(:character_id) { double }

        subject { described_class.new(character_id) }

        let(:eve_character) { instance_double(Eve::Character) }

        before { expect(Eve::Character).to receive(:find_or_initialize_by).with(character_id: character_id).and_return(eve_character) }

        let(:json) { double }

        let(:url) { double }

        let(:new_etag) { double }

        let(:response) { double }

        let(:esi) do
          instance_double(EveOnline::ESI::Character,
            url: url,
            not_modified?: false,
            etag: new_etag,
            as_json: json,
            response: response)
        end

        before { expect(EveOnline::ESI::Character).to receive(:new).with(character_id: character_id).and_return(esi) }

        let(:etag) { instance_double(Eve::Etag, etag: "22c39689783a86032b8d43fa0b2e8f4809c4f38a585e39471035aa8b") }

        before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

        before { expect(esi).to receive(:etag=).with("22c39689783a86032b8d43fa0b2e8f4809c4f38a585e39471035aa8b") }

        before { expect(eve_character).to receive(:update!).with(json) }

        before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when character not found" do
        let(:character_id) { double }

        subject { described_class.new(character_id) }

        let(:eve_character) { instance_double(Eve::Character) }

        before { expect(Eve::Character).to receive(:find_or_initialize_by).with(character_id: character_id).and_return(eve_character) }

        before { expect(EveOnline::ESI::Character).to receive(:new).with(character_id: character_id).and_raise(EveOnline::Exceptions::ResourceNotFound) }

        before { expect(eve_character).to receive(:destroy!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context "when no fresh data available" do
      let(:character_id) { double }

      subject { described_class.new(character_id) }

      let(:eve_character) { instance_double(Eve::Character) }

      before { expect(Eve::Character).to receive(:find_or_initialize_by).with(character_id: character_id).and_return(eve_character) }

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::Character,
          url: url,
          not_modified?: true)
      end

      before { expect(EveOnline::ESI::Character).to receive(:new).with(character_id: character_id).and_return(esi) }

      let(:etag) { instance_double(Eve::Etag, etag: "22c39689783a86032b8d43fa0b2e8f4809c4f38a585e39471035aa8b") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("22c39689783a86032b8d43fa0b2e8f4809c4f38a585e39471035aa8b") }

      before { expect(eve_character).not_to receive(:update!) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
