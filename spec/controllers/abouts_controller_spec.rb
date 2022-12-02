# frozen_string_literal: true

require "rails_helper"

describe AboutsController do
  it { should be_an(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#show" do
    before { get :show }

    it { should respond_with(:ok) }

    it { should render_template(:show) }
  end
end
