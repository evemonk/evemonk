# frozen_string_literal: true

require "rails_helper"

describe Eve::BaseImporter do
  describe "#import!" do
    before { expect(subject).to receive(:configure_middlewares) }

    before { expect(subject).to receive(:configure_etag) }

    context "when block" do
      specify { expect { subject.import! {} }.not_to raise_error }
    end

    context "when no block given" do
      specify { expect { subject.import! }.not_to raise_error }
    end
  end

  describe "#esi" do
    specify { expect { subject.esi }.to raise_error(NotImplementedError) }
  end

  describe "#import" do
    specify { expect { subject.import }.to raise_error(NotImplementedError) }
  end

  # private methods

  describe "#configure_middlewares" do
    let(:statistics_middleware) { double }

    let(:cool_down_middleware) { double }

    let(:esi) { double }

    before { expect(subject).to receive(:statistics_middleware).and_return(statistics_middleware) }

    before { expect(subject).to receive(:cool_down_middleware).and_return(cool_down_middleware) }

    before { expect(subject).to receive(:esi).and_return(esi).twice }

    before { expect(esi).to receive(:add_middleware).and_return(statistics_middleware) }

    before { expect(esi).to receive(:add_middleware).and_return(cool_down_middleware) }

    specify { expect { subject.send(:configure_middlewares) }.not_to raise_error }
  end

  describe "#update_etag" do
    let(:etag) { double }

    let(:response) { double }

    let(:esi) { double(etag: etag, response: response) }

    before { expect(subject).to receive(:esi).and_return(esi).twice }

    let(:etag) { instance_double(Eve::Etag) }

    before { expect(subject).to receive(:etag).and_return(etag) }

    before { expect(etag).to receive(:update!).with({etag: etag, body: response}) }

    specify { expect { subject.send(:update_etag) }.not_to raise_error }
  end

  describe "#statistics_middleware" do
    specify do
      expect(subject.send(:statistics_middleware)).to eq(class: StatisticsMiddleware)
    end
  end

  describe "#cool_down_middleware" do
    specify do
      expect(subject.send(:cool_down_middleware)).to eq(class: CoolDownMiddleware)
    end
  end
end
