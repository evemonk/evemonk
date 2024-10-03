# frozen_string_literal: true

require "rails_helper"

RSpec.describe WellKnownController do
  it { expect(subject).to be_an(ApplicationController) }

  it { expect(subject).not_to use_before_action(:authenticate_user!) }

  describe "#change_password" do
    before { get :change_password }

    it { expect(subject).to respond_with(:moved_permanently) }

    it { expect(subject).to redirect_to(edit_user_registration_path) }
  end
end
