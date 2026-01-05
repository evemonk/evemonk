# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::RefreshCharacterAccessToken do
  context "when token fresh" do
    let(:character) { create(:character, character_id: 1_337_512_245) }

    let!(:character_scope) do
      create(:character_scope,
        character: character,
        token_expires_at: 1.day.from_now)
    end

    subject { described_class.new(character_scope) }

    before { expect(character_scope).not_to receive(:update!) }

    specify { expect { subject.refresh }.not_to raise_error }
  end

  context "when token needed to refresh" do
    before { VCR.insert_cassette "api/refresh_character_access_token/success" }

    after { VCR.eject_cassette }

    before { Rails.application.config.evemonk.eve_online_sso = {client_id: "eve-online-sso-client-id", secret_key: "eve-online-sso-secret-key"} }

    before { Rails.application.config.evemonk.eve_online_sso = {} }

    let(:character) { create(:character, character_id: 1_337_512_245) }

    let(:character_scope) do
      create(:character_scope,
        character: character,
        refresh_token: "fresh-token-1232132132132131231312312312312312321321321321312312",
        token_expires_at: Time.zone.now)
    end

    subject { described_class.new(character_scope) }

    before { expect(character_scope).to receive(:update!) }

    specify { expect { subject.refresh }.not_to raise_error }
  end

  context "when oauth2 error" do
    before { freeze_time }

    before { Rails.application.config.evemonk.eve_online_sso = {client_id: "eve-online-sso-client-id", secret_key: "eve-online-sso-secret-key"} }

    before { Rails.application.config.evemonk.eve_online_sso = {} }

    before { VCR.insert_cassette "api/refresh_character_access_token/invalid_token" }

    after { VCR.eject_cassette }

    let(:character) { create(:character, character_id: 1_337_512_245) }

    let(:character_scope) do
      create(:character_scope,
        character: character,
        refresh_token: "fresh-token-1232132132132131231312312312312312321321321321312312",
        token_expires_at: Time.zone.now)
    end

    subject { described_class.new(character_scope) }

    before do
      #
      # character_scope.update!(esi_token_valid: false,
      #                         esi_token_invalid_at: Time.zone.now,
      #                         esi_last_error: e.description)
      #
      expect(character_scope).to receive(:update!).with(esi_token_valid: false,
        esi_token_invalid_at: Time.zone.now,
        esi_last_error: "Invalid refresh token. Unable to migrate grant.")
    end

    before do
      #
      # Rails.logger.info("OAuth2::Error: Character ID: #{character_scope.character.character_id} / code: #{e.code} / description: #{e.description}")
      #
      expect(Rails).to receive(:logger) do
        double.tap do |a|
          expect(a).to receive(:info).with("OAuth2::Error: Character ID: 1337512245 / code: invalid_grant / description: Invalid refresh token. Unable to migrate grant.")
        end
      end
    end

    specify { expect { subject.refresh }.to raise_error(CharacterInvalidToken) }
  end
end
