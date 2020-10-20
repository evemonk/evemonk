# frozen_string_literal: true

require "rails_helper"

describe CoolDownMiddleware do
  describe "when request is 200" do
    before { stub_request(:get, "https://esi.evetech.net/v2/status/").to_return(status: 200, body: {}.to_json) }

    let(:esi) { EveOnline::ESI::ServerStatus.new }

    let(:conn) do
      conn = Faraday.new { |f|
        f.use CoolDownMiddleware, esi: esi
        f.adapter Faraday.default_adapter
      }

      conn.get("https://esi.evetech.net/v2/status/")
    end

    specify { expect(conn.status).to eq(200) }
  end
end
