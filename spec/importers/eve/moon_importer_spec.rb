# frozen_string_literal: true

require "rails_helper"

describe Eve::MoonImporter do
  let(:planet_id) { double }

  let(:moon_id) { double }

  subject { described_class.new(planet_id, moon_id) }

  it { should be_a(Eve::BaseImporter) }

  describe "#initialize" do
    its(:planet_id) { should eq(planet_id) }

    its(:moon_id) { should eq(moon_id) }
  end

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    let(:eve_moon) { instance_double(Eve::Moon) }

    before { expect(Eve::Moon).to receive(:find_or_initialize_by).with(id: moon_id, planet_id: planet_id).and_return(eve_moon) }

    context "when eve moon found" do
      let(:json) { double }

      let(:position_json) { double }

      let(:position) do
        instance_double(EveOnline::ESI::Models::Position,
          as_json: position_json)
      end

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseMoon,
          as_json: json,
          position: position)
      end

      before { expect(subject).to receive(:esi).and_return(esi).twice }

      before { expect(eve_moon).to receive(:update!).with(json) }

      before do
        #
        # eve_moon.position&.destroy
        #
        expect(eve_moon).to receive(:position) do
          double.tap do |a|
            expect(a).to receive(:destroy)
          end
        end
      end

      before do
        #
        # eve_moon.create_position!(esi.position.as_json)
        #
        expect(eve_moon).to receive(:create_position!).with(position_json)
      end

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when eve moon not found" do
      before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      before do
        #
        # Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Moon ID #{planet_id}/#{moon_id}"")

        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info).with("EveOnline::Exceptions::ResourceNotFound: Eve Moon ID #{planet_id}/#{moon_id}")
          end
        end
      end

      before { expect(eve_moon).to receive(:destroy!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseMoon) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseMoon) }

      before { expect(EveOnline::ESI::UniverseMoon).to receive(:new).with(id: moon_id).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
