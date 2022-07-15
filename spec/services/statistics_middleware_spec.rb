# frozen_string_literal: true

require "rails_helper"

describe StatisticsMiddleware do
  [200, 204, 304, 400, 401, 403, 404, 420, 500, 503, 504].each do |status|
    describe "when request is #{status}" do
      before { stub_request(:get, "https://esi.evetech.net/v2/status/").to_return(status: status, body: {}.to_json) }

      let(:esi) { EveOnline::ESI::ServerStatus.new }

      before do
        conn = Faraday.new { |f|
          f.use StatisticsMiddleware
          f.adapter Faraday.default_adapter
        }

        conn.get("https://esi.evetech.net/v2/status/")
      end

      let(:method) { "esi_requests_#{status}_counter" }

      specify { expect(Yabeda.evemonk.public_send(method).values).to eq({total: "success"} => 1) }
    end
  end
end
