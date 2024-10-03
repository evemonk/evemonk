# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::CategoriesController do
  it { is_expected.to be_a(ApplicationController) }

  it { is_expected.to_not use_before_action(:authenticate_user!) }

  describe "#index" do
    before { get :index }

    it { is_expected.to respond_with(:ok) }

    it { is_expected.to render_template(:index) }
  end

  describe "#show" do
    before { get :show, params: {id: "1"} }

    it { is_expected.to respond_with(:ok) }

    it { is_expected.to render_template(:show) }
  end
end
