# frozen_string_literal: true

require "rails_helper"

describe CoolDownMiddleware do
  context "when esi_error_limit_remain and esi_error_limit_remain_till are not set yet" do
    before { VCR.insert_cassette "services/cool_down_middleware" }

    after { VCR.eject_cassette }

    let(:redis) { instance_double(Redis) }

    before { expect(Redis).to receive(:new).and_return(redis).exactly(4).times }

    before { expect(redis).to receive(:get).with("esi_error_limit_remain").and_return(nil) }

    before { expect(redis).to receive(:get).with("esi_error_limit_remain_till").and_return(nil) }

    before do
      #
      # redis.set("esi_error_limit_remain",
      #   esi_error_limit_remain.to_i,
      #   ex: esi_error_limit_reset.to_i)
      #
      expect(redis).to receive(:set).with("esi_error_limit_remain", 100, ex: 19)
    end

    before do
      #
      # redis.set("esi_error_limit_remain_till",
      #   esi_error_limit_reset.to_i.seconds.from_now.iso8601,
      #   ex: esi_error_limit_reset.to_i)
      expect(redis).to receive(:set).with("esi_error_limit_remain_till", 19.seconds.from_now.iso8601, ex: 19)
    end

    before { expect(Kernel).not_to receive(:sleep) }

    let(:esi) { EveOnline::ESI::ServerStatus.new }

    let(:conn) do
      conn = Faraday.new { |f|
        f.use CoolDownMiddleware
        f.adapter Faraday.default_adapter
      }

      conn.get("https://esi.evetech.net/v2/status/")
    end

    specify { expect { conn.status }.not_to raise_error }
  end

  context "when esi_error_limit_remain and esi_error_limit_remain_till are already set" do
    before { travel_to Time.zone.now }

    before { VCR.insert_cassette "services/cool_down_middleware" }

    after { VCR.eject_cassette }

    let(:redis) { instance_double(Redis) }

    before { expect(Redis).to receive(:new).and_return(redis).exactly(4).times }

    before { expect(redis).to receive(:get).with("esi_error_limit_remain").and_return("49") }

    before { expect(redis).to receive(:get).with("esi_error_limit_remain_till").and_return(51.seconds.from_now.iso8601) }

    before { expect(Kernel).to receive(:sleep).with(51) }

    before do
      #
      # redis.set("esi_error_limit_remain",
      #   esi_error_limit_remain.to_i,
      #   ex: esi_error_limit_reset.to_i)
      #
      expect(redis).to receive(:set).with("esi_error_limit_remain", 100, ex: 19)
    end

    before do
      #
      # redis.set("esi_error_limit_remain_till",
      #   esi_error_limit_reset.to_i.seconds.from_now.iso8601,
      #   ex: esi_error_limit_reset.to_i)
      expect(redis).to receive(:set).with("esi_error_limit_remain_till", 19.seconds.from_now.iso8601, ex: 19)
    end

    let(:esi) { EveOnline::ESI::ServerStatus.new }

    let(:conn) do
      conn = Faraday.new { |f|
        f.use CoolDownMiddleware
        f.adapter Faraday.default_adapter
      }

      conn.get("https://esi.evetech.net/v2/status/")
    end

    specify { expect { conn.status }.not_to raise_error }
  end
end
