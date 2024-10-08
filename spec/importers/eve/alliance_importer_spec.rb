# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::AllianceImporter do
  let(:id) { double }

  subject { described_class.new(id) }

  it { expect(subject).to be_a(Eve::BaseImporter) }

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    let(:eve_alliance) { instance_double(Eve::Alliance) }

    before { expect(Eve::Alliance).to receive(:find_or_initialize_by).with(id: id).and_return(eve_alliance) }

    context "when eve alliance resource found" do
      let(:json) { double }

      let(:esi) { instance_double(EveOnline::ESI::Alliance, as_json: json) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      before { expect(eve_alliance).to receive(:update!).with(json) }

      before { expect(eve_alliance).to receive(:reset_corporations_count) }

      before { expect(eve_alliance).to receive(:reset_characters_count) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when eve alliance resource not found" do
      before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      before do
        #
        # Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Alliance ID #{id}")

        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info).with("EveOnline::Exceptions::ResourceNotFound: Eve Alliance ID #{id}")
          end
        end
      end

      before { expect(eve_alliance).to receive(:destroy!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::Alliance) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::Alliance) }

      before { expect(EveOnline::ESI::Alliance).to receive(:new).with(alliance_id: id).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
