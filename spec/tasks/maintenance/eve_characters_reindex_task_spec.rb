# frozen_string_literal: true

require "rails_helper"

RSpec.describe Maintenance::EveCharactersReindexTask do
  describe "#process" do
    before { expect(Eve::Character).to receive(:reindex!).and_call_original }

    specify { expect { subject.process }.not_to raise_error }
  end
end
