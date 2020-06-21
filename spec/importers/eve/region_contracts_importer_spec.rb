# frozen_string_literal: true

require "rails_helper"

describe Eve::RegionContractsImporter do
  let(:region_id) { double }

  let(:page) { double }

  subject { described_class.new(region_id, page) }

  describe "#initialize" do
    its(:region_id) { should eq(region_id) }

    its(:page) { should eq(page) }
  end

  describe "#import" do
    specify { expect { subject.import }.not_to raise_error }
  end
end
