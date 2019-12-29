# frozen_string_literal: true

require "rails_helper"

describe Universe::TypesController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:require_login) }

  describe "#show" do
    before do
      #
      # Eve::Type.includes(:group,
      #                    type_dogma_attributes: :dogma_attribute,
      #                    market_group: { parent_group: { parent_group: :parent_group }})
      #          .find_by!(type_id: params[:id])
      #          .decorate
      #
      expect(Eve::Type).to receive(:includes).with(:group,
        type_dogma_attributes: :dogma_attribute,
        market_group: {parent_group: {parent_group: :parent_group}}) do
        double.tap do |a|
          expect(a).to receive(:find_by!).with(type_id: "9899") do
            double.tap do |b|
              expect(b).to receive(:decorate)
            end
          end
        end
      end
    end

    before { get :show, params: {id: "9899"} }

    it { should respond_with(:ok) }

    it { should render_template(:show) }
  end
end
