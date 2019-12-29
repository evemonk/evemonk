# frozen_string_literal: true

require "rails_helper"

describe Universe::GroupsController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:require_login) }

  describe "#show" do
    before { get :show, params: {id: "1"} }

    it { should respond_with(:ok) }

    it { should render_template(:show) }
  end
end
