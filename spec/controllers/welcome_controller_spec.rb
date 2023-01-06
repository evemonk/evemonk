# frozen_string_literal: true

require "rails_helper"

describe WelcomeController do
  it { should be_an(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#index" do
    before { get :index }

    it { should respond_with(:ok) }

    it { should render_template(:index) }
  end
end
