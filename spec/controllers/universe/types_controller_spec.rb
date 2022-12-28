# frozen_string_literal: true

require "rails_helper"

describe Universe::TypesController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#show" do
    before do
      #
      # Eve::Type.includes(group: :category,,
      #                    type_dogma_attributes: {dogma_attribute: [:unit, :icon]},
      #                    market_group: { parent_group: { parent_group: :parent_group }})
      #          .find_by!(type_id: params[:id])
      #
      expect(Eve::Type).to receive(:includes).with({
        group: :category,
        type_dogma_attributes: {dogma_attribute: [:unit, :icon]},
        market_group: {parent_group: {parent_group: :parent_group}}
      }) do
        double.tap do |a|
          expect(a).to receive(:find_by!).with(type_id: "9899")
        end
      end
    end

    before { get :show, params: {id: "9899"} }

    it { should respond_with(:ok) }

    it { should render_template(:show) }
  end
end
