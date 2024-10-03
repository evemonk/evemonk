# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::GroupsController do
  it { is_expected.to be_a(ApplicationController) }

  it { is_expected.not_to use_before_action(:authenticate_user!) }

  describe "#show" do
    before { get :show, params: {id: "1"} }

    it { is_expected.to respond_with(:ok) }

    it { is_expected.to render_template(:show) }
  end
end
