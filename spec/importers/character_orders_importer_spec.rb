# frozen_string_literal: true

require "rails_helper"

describe CharacterOrdersImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#update!" do
    context "when scope present" do
      before { expect(subject).to receive(:refresh_character_access_token) }

      let(:access_token) { double }

      let(:character) do
        instance_double(Character,
          character_id: character_id,
          access_token: access_token,
          scopes: "esi-markets.read_character_orders.v1")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(4).times }

      let(:json) { double }

      let(:order_id) { double }

      let(:order) do
        instance_double(EveOnline::ESI::Models::CharacterOrder,
          order_id: order_id,
          as_json: json)
      end

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterOrders,
                        orders: [order],
                        scope: "esi-markets.read_character_orders.v1")
      end

      before { expect(EveOnline::ESI::CharacterOrders).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

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

      specify { expect { subject.update! }.not_to raise_error }
    end

    context "when scope not present" do
      # TODO
    end
  end
end
