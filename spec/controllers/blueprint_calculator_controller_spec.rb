# frozen_string_literal: true

require "rails_helper"

describe BlueprintCalculatorController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#index" do
    before { get :index }

    it { should respond_with(:ok) }

    it { should render_template(:index) }
  end

  describe "#show" do
    before do
      #
      # Eve::Blueprint.find_by!(type_id: params[:id])
      #
      expect(Eve::Blueprint).to receive(:find_by!).with(type_id: "24699")
    end

    before { get :show, params: {id: 24_699} }

    it { should respond_with(:ok) }

    it { should render_template(:show) }
  end
end
