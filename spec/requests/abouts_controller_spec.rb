# frozen_string_literal: true

require "rails_helper"

RSpec.describe AboutsController do
  it { should be_an(ApplicationController) }

  describe "#show" do
    before { get about_url }

    it "is expected to render template show with status ok" do
      expect(response).to render_template(:show)

      expect(response).to have_http_status(:ok)

      expect(response.body).to include("About EveMonk")
    end
  end
end
