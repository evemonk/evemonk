# frozen_string_literal: true

require "rails_helper"

describe Api::RefreshCharacterAccessToken do
  context "when token fresh" do
    let(:character) do
      create(:character,
        token_expires_at: 1.day.from_now)
    end

    subject { described_class.new(character) }

    before { expect(character).not_to receive(:update!) }

    specify { expect { subject.refresh }.not_to raise_error }
  end

  context "when token needed to refresh" do
    before { VCR.insert_cassette "api/refresh_character_access_token/success" }

    after { VCR.eject_cassette }

    before { expect(Setting).to receive(:eve_online_sso_client_id).and_return("eve-online-sso-client-id") }

    before { expect(Setting).to receive(:eve_online_sso_secret_key).and_return("eve-online-sso-secret-key") }

    let(:character) do
      create(:character,
        character_id: 1_337_512_245,
        refresh_token: "fresh-token-1232132132132131231312312312312312321321321321312312",
        token_expires_at: Time.zone.now)
    end

    subject { described_class.new(character) }

    before { expect(character).to receive(:update!) }

    specify { expect { subject.refresh }.not_to raise_error }
  end

  context "when oauth2 error" do
    before { travel_to Time.zone.now }

    before { expect(Setting).to receive(:eve_online_sso_client_id).and_return("eve-online-sso-client-id") }

    before { expect(Setting).to receive(:eve_online_sso_secret_key).and_return("eve-online-sso-secret-key") }

    before { VCR.insert_cassette "api/refresh_character_access_token/invalid_token" }

    after { VCR.eject_cassette }

    let(:character) do
      create(:character,
        character_id: 1_337_512_245,
        refresh_token: "fresh-token-1232132132132131231312312312312312321321321321312312",
        token_expires_at: Time.zone.now)
    end

    subject { described_class.new(character) }

    before do
      #
      # character.update!(esi_token_valid: false,
      #                   esi_token_invalid_at: Time.zone.now,
      #                   esi_last_error: e.description)
      #
      expect(character).to receive(:update!).with(esi_token_valid: false,
        esi_token_invalid_at: Time.zone.now,
        esi_last_error: "Invalid refresh token. Unable to migrate grant.")
    end

    before do
      #
      # Rails.logger.info("OAuth2::Error: Character ID: #{character.character_id} / code: #{e.code} / description: #{e.description}")
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
