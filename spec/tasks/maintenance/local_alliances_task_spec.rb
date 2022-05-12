# frozen_string_literal: true

require "rails_helper"

describe Maintenance::LocalAlliancesTask do
  it { should delegate_method(:count).to(:collection) }

  describe "#collection" do
    before { expect(Eve::Alliance).to receive(:all) }

    specify { expect { subject.collection }.not_to raise_error }
  end

  describe "#process" do
  end
end
