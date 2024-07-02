# frozen_string_literal: true

require "rails_helper"

RSpec.describe WellKnownController do
  it { should be_an(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#change_password" do
    before { get :change_password }

    it { should respond_with(:moved_permanently) }

    it { should redirect_to(edit_user_registration_path) }
  end
end
