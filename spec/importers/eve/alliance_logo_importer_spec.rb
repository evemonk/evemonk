# frozen_string_literal: true

require "rails_helper"

describe Eve::AllianceLogoImporter do
  let(:id) { double }

  subject { described_class.new(id) }

  it { should be_a(Eve::BaseImporter) }

  specify { expect(described_class::ALLIANCES_LOGO_URL).to eq("https://images.evetech.net/alliances/%s/logo") }

  describe "#import" do
    let(:id) { 434_243_723 }

    let(:logo) { instance_double(ActiveStorage::Attached::One) }

    let(:eve_alliance) { instance_double(Eve::Alliance, logo: logo) }

    before do
      expect(Eve::Alliance).to receive(:find_or_initialize_by)
        .with(id: id)
        .and_return(eve_alliance)
    end

    let(:tempfile) { instance_double(Tempfile) }

    before do
      expect(Down).to receive(:download)
        .with("https://images.evetech.net/alliances/434243723/logo")
        .and_return(tempfile)
    end

    before do
      expect(logo).to receive(:attach)
        .with(io: tempfile, filename: "434243723.png")
    end

    before { expect(eve_alliance).to receive(:save!) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
