# frozen_string_literal: true

require "rails_helper"

describe Eve::StargateImporter do
  let(:stargate_id) { double }

  subject { described_class.new(stargate_id) }

  it { should be_a(Eve::BaseImporter) }

  describe "#initialize" do
    its(:stargate_id) { should eq(stargate_id) }
  end

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    let(:eve_stargate) { instance_double(Eve::Stargate) }

    before { expect(Eve::Stargate).to receive(:find_or_initialize_by).with(id: stargate_id).and_return(eve_stargate) }

    context "when eve stargate found" do
      let(:json) { double }

      let(:position_json) { double }

      let(:position) do
        instance_double(EveOnline::ESI::Models::Position,
          as_json: position_json)
      end

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseStargate,
          as_json: json,
          position: position)
      end

      before { expect(subject).to receive(:esi).and_return(esi).twice }

      before { expect(eve_stargate).to receive(:update!).with(json) }

      before do
        #
        # eve_stargate.position&.destroy
        #
        expect(eve_stargate).to receive(:position) do
          double.tap do |a|
            expect(a).to receive(:destroy)
          end
        end
      end

      before do
        #
        # eve_stargate.create_position!(esi.position.as_json)
        #
        expect(eve_stargate).to receive(:create_position!).with(position_json)
      end

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when eve stargate not found" do
      before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      before do
        #
        # Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Stargate ID #{stargate_id}")

        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info).with("EveOnline::Exceptions::ResourceNotFound: Eve Stargate ID #{stargate_id}")
          end
        end
      end

      before { expect(eve_stargate).to receive(:destroy!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseStargate) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseStargate) }

      before { expect(EveOnline::ESI::UniverseStargate).to receive(:new).with(id: stargate_id).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
