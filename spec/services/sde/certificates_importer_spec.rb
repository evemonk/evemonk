# frozen_string_literal: true

require "rails_helper"

describe Sde::CertificatesImporter do
  let(:file) { double }

  subject { described_class.new(file) }

  describe "#initialize" do
    its(:file) { should eq(file) }
  end

  describe "#import" do
    specify { expect { subject.import }.not_to raise_error }
  end
end
