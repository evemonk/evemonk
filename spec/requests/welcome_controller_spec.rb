# frozen_string_literal: true

require "rails_helper"

RSpec.describe WelcomeController do
  it { expect(subject).to be_an(ApplicationController) }

  describe "#index" do
    before { get root_path }

    context "when user not logged in" do
      it "is expected to render template index with status ok" do
        expect(response).to render_template(:index)

        expect(response).to have_http_status(:ok)

        expect(response.body).to include("<u>A</u>lliances")

        expect(response.body).to include("<u>C</u>orporations")
      end
    end

    context "when user is logged in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it "is expected to render template index with status ok" do
        expect(response).to render_template(:index)

        expect(response).to have_http_status(:ok)

        expect(response.body).to include("<u>A</u>lliances")

        expect(response.body).to include("<u>C</u>orporations")
      end
    end
  end
end
