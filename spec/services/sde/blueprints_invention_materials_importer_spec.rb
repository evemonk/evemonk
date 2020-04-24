# frozen_string_literal: true

require "rails_helper"

describe Sde::BlueprintsInventionMaterialsImporter do
  let(:file) { double }

  subject { described_class.new(file) }

  describe "#initialize" do
    its(:file) { should eq(file) }
  end

  describe "#import" do
  end
end
