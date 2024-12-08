# frozen_string_literal: true

require "rails_helper"

RSpec.describe BlueprintsController do
  it { expect(subject).to be_an(ApplicationController) }

  describe "#index" do
    context "when user signed in" do
      context "when user is own character" do
        let(:user) { create(:user) }

        let(:character) { create(:character, user: user) }

        before { sign_in(user) }

        before { get character_blueprints_path(character) }

        it { expect(response).to have_http_status(:ok) }

        it { expect(response.body).to include("Blueprints") }
      end

      context "when user is not own character" do
        let(:user) { create(:user) }

        let(:character) { create(:character) }

        before { sign_in(user) }

        before { get character_blueprints_path(character) }

        it { expect(response).to have_http_status(:not_found) }
      end
    end

    context "when user not signed in" do
      let(:character) { create(:character) }

      before { get character_blueprints_path(character) }

      it { expect(response).to have_http_status(:found) }

      it { expect(subject).to redirect_to(new_user_session_path) }
    end
  end

  # describe "#show" do
  #   context "when user signed in" do
  #     context "when user is own character" do
  #
  #     end
  #
  #     context "when user is not own character" do
  #
  #     end
  #   end
  #
  #   context "when user not signed in" do
  #     let(:character) { create(:character) }
  #
  #     before { get character_blueprints_path(character) }
  #
  #     it { expect(response).to have_http_status(:found) }
  #
  #     it { expect(subject).to redirect_to(new_user_session_path) }
  #   end
  # end

  # describe "#show" do
  #   context "when user signed in" do
  #     let(:user) { create(:user) }
  #
  #     before { sign_in(user) }
  #
  #     before { expect(subject).to receive(:current_user_locale) }
  #
  #     let(:character) { instance_double(Character) }
  #
  #     before do
  #       #
  #       # subject.current_user
  #       #        .characters
  #       #        .includes(:alliance, :corporation)
  #       #        .find_by!(character_id: params[:character_id]) # => character
  #       #
  #       expect(subject).to receive(:current_user) do
  #         double.tap do |a|
  #           expect(a).to receive(:characters) do
  #             double.tap do |b|
  #               expect(b).to receive(:includes).with(:alliance, :corporation) do
  #                 double.tap do |c|
  #                   expect(c).to receive(:find_by!).with(character_id: "1")
  #                     .and_return(character)
  #                 end
  #               end
  #             end
  #           end
  #         end
  #       end
  #     end
  #
  #     before do
  #       #
  #       # character.character_blueprints
  #       #          .includes(:blueprint)
  #       #          .find_by!(item_id: params[:id])
  #       #
  #       expect(character).to receive(:character_blueprints) do
  #         double.tap do |a|
  #           expect(a).to receive(:includes).with(:blueprint) do
  #             double.tap do |b|
  #               expect(b).to receive(:find_by!).with(item_id: "2")
  #             end
  #           end
  #         end
  #       end
  #     end
  #
  #     before { get :show, params: {character_id: "1", id: "2"} }
  #
  #     it { expect(subject).to respond_with(:ok) }
  #
  #     it { expect(subject).to render_template(:show) }
  #   end
  # end
end
