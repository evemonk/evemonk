# frozen_string_literal: true

require "rails_helper"

RSpec.describe WellKnownController do
  it { is_expected.to be_an(ApplicationController) }

  it { is_expected.to_not use_before_action(:authenticate_user!) }

  describe "#change_password" do
    before { get :change_password }

    it { is_expected.to respond_with(:moved_permanently) }

    it { is_expected.to redirect_to(edit_user_registration_path) }
  end
end
