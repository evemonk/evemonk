# frozen_string_literal: true

require "rails_helper"

describe Eve::CorporationLogoImporter do
  let(:id) { double }

  subject { described_class.new(id) }

  it { should be_a(Eve::BaseImporter) }

  specify { expect(described_class::CORPORATIONS_LOGO_URL).to eq("https://images.evetech.net/corporations/%s/logo") }

  describe "#import" do
    let(:id) { 109_299_958 }

    let(:logo) { instance_double(ActiveStorage::Attached::One) }

    let(:eve_corporation) { instance_double(Eve::Corporation, logo: logo) }

    before do
      expect(Eve::Corporation).to receive(:find_or_initialize_by)
        .with(id: id)
        .and_return(eve_corporation)
    end

    let(:tempfile) { instance_double(Tempfile) }

    before do
      expect(Down).to receive(:download)
        .with("https://images.evetech.net/corporations/109299958/logo")
        .and_return(tempfile)
    end

    before do
      expect(logo).to receive(:attach)
        .with(io: tempfile, filename: "109299958.png")
    end

    before { expect(eve_corporation).to receive(:save!) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
