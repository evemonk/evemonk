# frozen_string_literal: true

require "rails_helper"

RSpec.describe WellKnownController do
  it { expect(subject).to be_an(ApplicationController) }

  describe "#change_password" do
    before { get "/.well-known/change-password" }

    it { expect(response).to have_http_status(:moved_permanently) }

    it { expect(subject).to redirect_to(edit_user_registration_path) }
  end
end
