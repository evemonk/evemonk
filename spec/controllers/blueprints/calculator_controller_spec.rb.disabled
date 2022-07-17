# frozen_string_literal: true

require "rails_helper"

describe Blueprints::CalculatorController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#index" do
    before do
      #
      # Eve::SearchBlueprintsQuery.new(params[:q]).query.limit(10)
      #
      expect(Eve::SearchBlueprintsQuery).to receive(:new).with("drake") do
        double.tap do |a|
          expect(a).to receive(:query) do
            double.tap do |b|
              expect(b).to receive(:limit).with(10)
            end
          end
        end
      end
    end

    before { get :index, params: {q: "drake"} }

    it { should respond_with(:ok) }

    it { should render_template(:index) }
  end

  describe "#show" do
    before do
      #
      # Eve::Blueprint.published.find_by!(type_id: params[:id])
      #
      expect(Eve::Blueprint).to receive(:published) do
        double.tap do |a|
          expect(a).to receive(:find_by!).with(type_id: "24699")
        end
      end
    end

    before { get :show, params: {id: 24_699} }

    it { should respond_with(:ok) }

    it { should render_template(:show) }
  end
end
