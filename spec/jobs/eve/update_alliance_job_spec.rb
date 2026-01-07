# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateAllianceJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:id) { double }

    context "when eve alliance enabled" do
      before { Flipper.enable(:eve_alliance) }

      after { Flipper.disable(:eve_alliance) }

      before do
        #
        # Eve::AllianceImporter.new(id).import
        #
        expect(Eve::AllianceImporter).to receive(:new).with(id) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end

      specify { expect { subject.perform(id) }.not_to raise_error }
    end

    context "when eve alliance disabled" do
      before { expect(Eve::AllianceImporter).not_to receive(:new) }

      specify { expect { subject.perform(id) }.not_to raise_error }
    end
  end
end
