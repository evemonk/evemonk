# frozen_string_literal: true

require "rails_helper"

RSpec.describe AboutsController do
  it { should be_an(ApplicationController) }

  describe "#show" do
    before { get about_url }

    it { expect(response).to render_template(:show) }

    it { expect(response).to have_http_status(:ok) }
  end
end
