# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharactersController do
  it { expect(subject).to be_an(ApplicationController) }

  describe "#index" do
    context "when user signed in" do
      let(:user) { create(:user) }

      let!(:character) { create(:character, user: user) }

      before { sign_in(user) }

      before { get characters_path }

      it { expect(response).to have_http_status(:ok) }

      it { expect(response.body).to include("My characters") }
    end

    context "when user not signed in" do
      before { get characters_path }

      it { expect(response).to have_http_status(:found) }

      it { expect(subject).to redirect_to(new_user_session_path) }
    end
  end

  describe "#show" do
    context "when user signed in" do
      context "when user is own character" do
        let(:user) { create(:user) }

        let(:character) { create(:character, user: user, name: "Johnn Dillinger") }

        before { sign_in(user) }

        before { get character_path(character) }

        it { expect(response).to have_http_status(:ok) }

        it { expect(response.body).to include("Johnn Dillinger") }
      end

      context "when user is not own character" do
        let(:user) { create(:user) }

        let(:character) { create(:character) }

        before { sign_in(user) }

        before { get character_path(character) }

        it { expect(response).to have_http_status(:found) }

        it { expect(subject).to redirect_to(root_path) }
      end
    end

    context "when user not signed in" do
      let(:character) { create(:character) }

      before { get character_path(character) }

      it { expect(response).to have_http_status(:found) }

      it { expect(subject).to redirect_to(new_user_session_path) }
    end
  end

  describe "#update" do
    context "when user signed in" do
      context "when user is own character" do
        let(:user) { create(:user) }

        let(:character) { create(:character, user: user, name: "Johnn Dillinger") }

        before { sign_in(user) }

        before do
          #
          # UpdateCharacterInfoService.new(@character.character_id).execute
          #
          expect(UpdateCharacterInfoService).to receive(:new).with(character.character_id) do
            double.tap do |a|
              expect(a).to receive(:execute)
            end
          end
        end

        context "when format html" do
          before { patch character_path(character), params: {format: :html} }

          it { expect(response).to have_http_status(:found) }

          it { expect(subject).to redirect_to(character_path(character.character_id)) }
        end

        context "when format stream" do
          before { patch character_path(character), params: {format: :turbo_stream} }

          it { expect(response).to have_http_status(:ok) }

          it { expect(flash.now[:notice]).to eq("Character &laquo;Johnn Dillinger&raquo; scheduled to update. Check it later.") }
        end
      end

      context "when user is not own character" do
        let(:user) { create(:user) }

        let(:character) { create(:character) }

        before { sign_in(user) }

        context "when format html" do
          before { patch character_path(character), params: {format: :html} }

          it { expect(response).to have_http_status(:found) }

          it { expect(subject).to redirect_to(root_path) }
        end

        context "when format stream" do
          before { patch character_path(character), params: {format: :turbo_stream} }

          it { expect(response).to have_http_status(:found) }

          it { expect(subject).to redirect_to(root_path) }
        end
      end
    end

    context "when user not signed in" do
      let(:character) { create(:character) }

      before { patch character_path(character) }

      it { expect(response).to have_http_status(:found) }

      it { expect(subject).to redirect_to(new_user_session_path) }
    end
  end

  describe "#destroy" do
    context "when user signed in" do
      context "when user is own character" do
        let(:user) { create(:user) }

        let!(:character) { create(:character, user: user, name: "Johnn Dillinger") }

        before { sign_in(user) }

        context "when format html" do
          before do
            expect do
              delete character_path(character), params: {format: :html}
            end.to change(Character, :count).by(-1)
          end

          it { expect(response).to have_http_status(:see_other) }

          it { expect(subject).to redirect_to(characters_path) }

          it { expect(flash[:notice]).to eq("Character &laquo;Johnn Dillinger&raquo; was successfully removed.") }
        end

        context "when format stream" do
          before do
            expect do
              delete character_path(character), params: {format: :turbo_stream}
            end.to change(Character, :count).by(-1)
          end

          it { expect(response).to have_http_status(:ok) }

          it { expect(flash.now[:notice]).to eq("Character &laquo;Johnn Dillinger&raquo; was successfully removed.") }
        end
      end

      context "when user is not own character" do
        let(:user) { create(:user) }

        let(:character) { create(:character) }

        before { sign_in(user) }

        context "when format html" do
          before { delete character_path(character), params: {format: :html} }

          it { expect(response).to have_http_status(:found) }

          it { expect(subject).to redirect_to(root_path) }
        end

        context "when format stream" do
          before { delete character_path(character), params: {format: :turbo_stream} }

          it { expect(response).to have_http_status(:found) }

          it { expect(subject).to redirect_to(root_path) }
        end
      end
    end

    context "when user not signed in" do
      let!(:character) { create(:character) }

      before do
        expect do
          delete character_path(character), params: {format: :html}
        end.not_to change(Character, :count)
      end

      it { expect(response).to have_http_status(:found) }

      it { expect(subject).to redirect_to(new_user_session_path) }
    end
  end
end
