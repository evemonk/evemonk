# frozen_string_literal: true

require "rails_helper"

describe Eve::CertificateDashboard do
  it { should be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:certificate) { build(:eve_certificate, name: "Small Energy Turret") }

    specify { expect(subject.display_resource(certificate)).to eq("Small Energy Turret") }
  end
end
