# frozen_string_literal: true

require "rails_helper"

describe CharacterIndustryJobsImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#initialize" do
    subject { described_class.new(character_id) }

    its(:character_id) { should eq(character_id) }
  end

  describe "#update!" do
    
  end
end
