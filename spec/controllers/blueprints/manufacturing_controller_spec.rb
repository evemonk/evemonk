# frozen_string_literal: true

require "rails_helper"

describe Blueprints::ManufacturingController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#show" do
    before do
      #
      # Eve::Blueprint.blueprints.published.find(params[:id])
      #
      expect(Eve::Blueprint).to receive(:blueprints) do
        double.tap do |a|
          expect(a).to receive(:published) do
            double.tap do |b|
              expect(b).to receive(:find).with("24699")
            end
          end
        end
      end
    end

    before { get :show, params: {id: 24_699} }

    it { should respond_with(:ok) }

    it { should render_template(:show) }
  end
end
