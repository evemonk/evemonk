# frozen_string_literal: true

require "rails_helper"

describe Universe::MarketGroupsController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#index" do
    before { get :index }

    it { should respond_with(:ok) }

    it { should render_template(:index) }
  end

  describe "#show" do
    before { get :show, params: {id: "1"} }

    it { should respond_with(:ok) }

    it { should render_template(:show) }
  end
end
