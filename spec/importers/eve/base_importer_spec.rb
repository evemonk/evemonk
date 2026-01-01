# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::BaseImporter do
  describe "#import!" do
    # before { expect(subject).to receive(:configure_middlewares) }

    context "when block" do
      specify { expect { subject.import! {} }.not_to raise_error }
    end

    context "when no block given" do
      specify { expect { subject.import! }.not_to raise_error }
    end
  end

  describe "#client" do
    specify { expect { subject.client }.to raise_error(NotImplementedError) }
  end

  describe "#import" do
    specify { expect { subject.import }.to raise_error(NotImplementedError) }
  end

  # private methods

  describe "#configure_middlewares" do
    let(:statistics_middleware) { double }

    let(:cool_down_middleware) { double }

    let(:client) { instance_double(EveOnline::ESI::Client) }

    before { expect(subject).to receive(:statistics_middleware).and_return(statistics_middleware) }

    before { expect(subject).to receive(:cool_down_middleware).and_return(cool_down_middleware) }

    before { expect(subject).to receive(:client).and_return(client).twice }

    before { expect(client).to receive(:add_middleware).and_return(statistics_middleware) }

    before { expect(client).to receive(:add_middleware).and_return(cool_down_middleware) }

    specify { expect { subject.send(:configure_middlewares) }.not_to raise_error }
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
