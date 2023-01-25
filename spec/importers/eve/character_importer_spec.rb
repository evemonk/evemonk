# frozen_string_literal: true

require "rails_helper"

describe Eve::CharacterImporter do
  let(:id) { double }

  subject { described_class.new(id) }

  it { should be_a(Eve::BaseImporter) }

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    let(:eve_character) { instance_double(Eve::Character) }

    before { expect(Eve::Character).to receive(:find_or_initialize_by).with(id: id).and_return(eve_character) }

    context "when eve character found" do
      let(:json) { double }

      let(:esi) { instance_double(EveOnline::ESI::Character, as_json: json) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      before { expect(eve_character).to receive(:update!).with(json) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when eve character not found" do
      before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      before do
        #
        # Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Character ID #{id}")
        #
        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info).with("EveOnline::Exceptions::ResourceNotFound: Eve Character ID #{id}")
          end
        end
      end

      before { expect(eve_character).to receive(:destroy!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::Character) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::Character) }

      before { expect(EveOnline::ESI::Character).to receive(:new).with(character_id: id).and_return(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
