# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateCorporationJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:id) { 111_222 }

    context "when eve corporation enabled" do
      before { Flipper.enable(:eve_corporation) }

      after { Flipper.disable(:eve_corporation) }

      before do
        #
        # Eve::CorporationImporter.new(id).import
        #
        expect(Eve::CorporationImporter).to receive(:new).with(id) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end

      specify { expect { subject.perform(id) }.not_to raise_error }
    end

    context "when eve corporation disabled" do
      before { expect(Eve::CorporationImporter).not_to receive(:new) }

      specify { expect { subject.perform(id) }.not_to raise_error }
    end
  end
end
