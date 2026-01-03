# frozen_string_literal: true

require "rails_helper"

RSpec.describe Maintenance::EveBloodlinesTask do
  describe "#process" do
    before { expect(Eve::UpdateBloodlinesJob).to receive(:perform_later) }

    specify { expect { subject.process }.not_to raise_error }
  end
end
