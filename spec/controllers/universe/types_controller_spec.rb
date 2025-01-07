# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::TypesController, type: :controller do
  it { expect(subject).to be_an(ApplicationController) }

  it { expect(subject).not_to use_before_action(:authenticate_user!) }

  describe "#show" do
    before do
      #
      # Eve::Type.includes(group: :category,,
      #                    type_dogma_attributes: {dogma_attribute: [:unit, :icon]},
      #                    market_group: { parent_group: { parent_group: :parent_group }})
      #          .find(params[:id])
      #
      expect(Eve::Type).to receive(:includes).with(group: :category,
        type_dogma_attributes: {dogma_attribute: [:unit, :icon]},
        market_group: {parent_group: {parent_group: :parent_group}}) do
        double.tap do |a|
          expect(a).to receive(:find).with("9899")
        end
      end
    end

    before { get :show, params: {id: "9899"} }

    it { expect(subject).to respond_with(:ok) }

    it { expect(subject).to render_template(:show) }
  end
end
