# frozen_string_literal: true

require "rails_helper"

RSpec.describe RegistrationsController, type: :request do
  describe "#new" do
    before { get new_session_path }

    it { expect(response).to have_http_status(:ok) }
  end

  # TODO: more
end
