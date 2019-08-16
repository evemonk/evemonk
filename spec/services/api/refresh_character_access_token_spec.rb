# frozen_string_literal: true

require "rails_helper"

describe Api::RefreshCharacterAccessToken do
  context "when token fresh" do
    let(:character) do
      create(:character,
             token_expires_at: Time.zone.now + 1.day)
    end

    subject { described_class.new(character.character_id) }

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
             access_token: "expired-access-token123",
             refresh_token: "fresh-token-1232132132132131231312312312312312321321321321312312",
             token_expires_at: Time.zone.now)
    end

    subject { described_class.new(character.character_id) }

    before { expect(Character).to receive(:find_by).with(character_id: 1_337_512_245).and_return(character) }

    before { expect(character).to receive(:update!) }

    specify { expect { subject.refresh }.not_to raise_error }
  end
end
