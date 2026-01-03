# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateBloodlinesJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    context "when jobs eve bloodlines enabled" do
      before { Flipper.enable(:eve_bloodlines) }

      after { Flipper.disable(:eve_bloodlines) }

      before do
        #
        # LanguageMapper::LANGUAGES.each_value do |language|
        #   Eve::BloodlinesImporter.new(language).import
        # end
        #
        LanguageMapper::LANGUAGES.each_value do |language|
          expect(Eve::BloodlinesImporter).to receive(:new).with(language) do
            double.tap do |a|
              expect(a).to receive(:import)
            end
          end
        end
      end

      specify { expect { subject.perform }.not_to raise_error }
    end

    context "when jobs eve bloodlines disabled" do
      before { expect(Eve::BloodlinesImporter).not_to receive(:new) }

      specify { expect { subject.perform }.not_to raise_error }
    end
  end
end
