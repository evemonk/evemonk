# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::GroupsController do
  it { expect(subject).to be_an(ApplicationController) }

  it { expect(subject).not_to use_before_action(:authenticate_user!) }

  describe "#show" do
    before { get :show, params: {id: "1"} }

    it { expect(subject).to respond_with(:ok) }

    it { expect(subject).to render_template(:show) }
  end
end
