# frozen_string_literal: true

require "rails_helper"

describe CharacterOrdersImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#import!" do
    let(:character) { instance_double(Character) }

    before { expect(subject).to receive(:character).and_return(character) }

    let(:json) { double }

    let(:order_id) { double }

    let(:order) do
      instance_double(EveOnline::ESI::Models::CharacterOrder,
        order_id: order_id,
        as_json: json)
    end

    let(:esi) do
      instance_double(EveOnline::ESI::CharacterOrders,
        orders: [order])
    end

    before { expect(subject).to receive(:esi).and_return(esi) }

    let(:character_order) { instance_double(CharacterOrder) }

    before do
      #
      # character.character_orders.find_or_initialize_by(order_id: order.order_id) # => character_order
      #
      expect(character).to receive(:character_orders) do
        double.tap do |a|
          expect(a).to receive(:find_or_initialize_by).with(order_id: order_id)
            .and_return(character_order)
        end
      end
    end

    before { expect(character_order).to receive(:assign_attributes).with(json) }

    before { expect(character_order).to receive(:save!) }

    specify { expect { subject.import! }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterOrders) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterOrders) }

      let(:character) { instance_double(Character, character_id: character_id) }

      before { expect(subject).to receive(:character).and_return(character) }

      before { expect(EveOnline::ESI::CharacterOrders).to receive(:new).with({character_id: character_id}).and_return(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
