# frozen_string_literal: true

require "rails_helper"

RSpec.describe WellKnownController, type: :request do
  describe "#change_password" do
    before { get well_known_change_password_path }

    it { expect(response).to have_http_status(:moved_permanently) }

    it { expect(subject).to redirect_to(edit_user_registration_path) }
  end
end
