# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::CategoriesController do
  it { expect(subject).to be_a(ApplicationController) }

  it { expect(subject).not_to use_before_action(:authenticate_user!) }

  describe "#index" do
    before { get :index }

    it { expect(subject).to respond_with(:ok) }

    it { expect(subject).to render_template(:index) }
  end

  describe "#show" do
    before { get :show, params: {id: "1"} }

    it { expect(subject).to respond_with(:ok) }

    it { expect(subject).to render_template(:show) }
  end
end
