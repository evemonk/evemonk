# frozen_string_literal: true

require "rails_helper"

describe Eve::ServerStatusJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("server_status") }

  describe ".sidekiq_options" do
    specify { expect(described_class.sidekiq_options["retry"]).to eq(false) }
  end

  describe "#perform" do
    context "when eve_server_status_job enabled" do
      before { Flipper.enable(:eve_server_status_job) }

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

    context "when eve_server_status_job disabled" do
      before { Flipper.disable(:eve_server_status_job) }

      before { expect(Eve::ServerStatusImporter).not_to receive(:new) }

      specify { expect { subject.perform }.not_to raise_error }
    end
  end
end
