# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::StarImporter do
  let(:star_id) { double }

  subject { described_class.new(star_id) }

  it { expect(subject).to be_a(Eve::BaseImporter) }

  describe "#initialize" do
    its(:star_id) { is_expected.to eq(star_id) }
  end

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    let(:eve_star) { instance_double(Eve::Star) }

    before { expect(Eve::Star).to receive(:find_or_initialize_by).with(star_id: star_id).and_return(eve_star) }

    context "when eve star found" do
      let(:json) { double }

      let(:esi) { instance_double(EveOnline::ESI::UniverseStar, as_json: json) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      before { expect(eve_star).to receive(:update!).with(json) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when eve star not found" do
      before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      before do
        #
        # Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Star ID #{star_id}")

        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info).with("EveOnline::Exceptions::ResourceNotFound: Eve Star ID #{star_id}")
          end
        end
      end

      before { expect(eve_star).to receive(:destroy!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseStar) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseStar) }

      before { expect(EveOnline::ESI::UniverseStar).to receive(:new).with(id: star_id).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
