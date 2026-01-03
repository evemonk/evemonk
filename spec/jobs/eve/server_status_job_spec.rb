# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::ServerStatusJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("server_status") }

  describe "#perform" do
    context "when jobs eve server status enabled" do
      before { Flipper.enable(:eve_server_status) }

      after { Flipper.disable(:eve_server_status) }

      before do
        #
        # Eve::ServerStatusImporter.new.import
        #
        expect(Eve::ServerStatusImporter).to receive(:new) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end

      specify { expect { subject.perform }.not_to raise_error }
    end

    context "when jobs eve server status disabled" do
      before { expect(Eve::ServerStatusImporter).not_to receive(:new) }

      specify { expect { subject.perform }.not_to raise_error }
    end
  end
end
