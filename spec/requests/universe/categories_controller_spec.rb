# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::CategoriesController do
  it { expect(subject).to be_an(ApplicationController) }

  describe "#index" do
    let!(:category) { create(:eve_category, name_en: "Test Category") }

    before { get universe_categories_path }

    context "when user not logged in" do
      it "is expected to have http status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Test Category")
      end
    end

    context "when user is logged in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it "is expected to have http status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Test Category")
      end
    end
  end

  describe "#show" do
    let!(:category) { create(:eve_category, name_en: "Test Category") }

    before { get universe_category_path(category) }

    context "when user not logged in" do
      it "is expected to have http status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Test Category")
      end
    end

    context "when user is logged in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it "is expected to have http status ok" do
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("Test Category")
      end
    end
  end
end
