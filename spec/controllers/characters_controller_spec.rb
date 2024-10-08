# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharactersController do
  it { expect(subject).to be_an(ApplicationController) }

  it { expect(subject).to use_before_action(:authenticate_user!) }

  describe "#index" do
    context "when user signed in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      before { expect(subject).to receive(:current_user_locale) }

      before do
        #
        # subject.current_user
        #        .characters
        #        .includes(:alliance, :corporation)
        #        .order(created_at: :asc)
        #        .page(params[:page])
        #
        expect(subject).to receive(:current_user) do
          double.tap do |a|
            expect(a).to receive(:characters) do
              double.tap do |b|
                expect(b).to receive(:includes).with(:alliance, :corporation) do
                  double.tap do |c|
                    expect(c).to receive(:order).with(created_at: :asc) do
                      double.tap do |d|
                        expect(d).to receive(:page).with("1")
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end

      before { get :index, params: {page: "1"} }

      it { expect(subject).to respond_with(:ok) }

      it { expect(subject).to render_template(:index) }
    end

    context "when user not signed in" do
      before { get :index, params: {page: "1"} }

      it { expect(subject).to redirect_to(new_user_session_path) }
    end
  end

  describe "#show" do
    context "when user signed in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      before { expect(subject).to receive(:current_user_locale) }

      before do
        #
        # subject.current_user
        #        .characters
        #        .includes(:race, :bloodline, :faction, :alliance, :corporation, :current_ship_type)
        #        .find_by!(character_id: params[:id])
        #
        expect(subject).to receive(:current_user) do
          double.tap do |a|
            expect(a).to receive(:characters) do
              double.tap do |b|
                expect(b).to receive(:includes).with(:race, :bloodline, :faction, :alliance, :corporation, :current_ship_type) do
                  double.tap do |c|
                    expect(c).to receive(:find_by!).with(character_id: "1")
                  end
                end
              end
            end
          end
        end
      end

      before { get :show, params: {id: "1"} }

      it { expect(subject).to respond_with(:ok) }

      it { expect(subject).to render_template(:show) }
    end

    context "when user not signed in" do
      before { get :show, params: {id: "1"} }

      it { expect(subject).to redirect_to(new_user_session_path) }
    end
  end

  describe "#update" do
    context "when user signed in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      before { expect(subject).to receive(:current_user_locale) }

      let(:character) { build(:character, character_id: 1, name: "Green Black") }

      before do
        #
        # subject.current_user.characters.find_by!(character_id: params[:id])
        #
        expect(subject).to receive(:current_user) do
          double.tap do |a|
            expect(a).to receive(:characters) do
              double.tap do |b|
                expect(b).to receive(:find_by!).with(character_id: "1")
                  .and_return(character)
              end
            end
          end
        end
      end

      before do
        #
        # UpdateCharacterInfoService.new(@character.character_id).execute
        #
        expect(UpdateCharacterInfoService).to receive(:new).with(1) do
          double.tap do |a|
            expect(a).to receive(:execute)
          end
        end
      end

      context "when format turbo stream" do
        before { patch :update, params: {id: "1", format: "turbo_stream"} }

        it { expect(subject).to respond_with(:ok) }

        it { expect(subject).to render_template(:update) }

        it { expect(subject).to set_flash.now[:notice].to("Character &laquo;#{character.name}&raquo; scheduled to update. Check it later.") }
      end

      context "when format html" do
        before { patch :update, params: {id: "1", format: "html"} }

        it { expect(subject).to redirect_to(character_path(character.character_id)) }
      end
    end

    context "when user not signed in" do
      before { patch :update, params: {id: "1"} }

      it { expect(subject).to redirect_to(new_user_session_path) }
    end
  end

  describe "#destroy" do
    context "when user signed in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      before { expect(subject).to receive(:current_user_locale) }

      let(:character) { instance_double(Character) }

      before do
        #
        # subject.current_user.characters.find_by!(character_id: params[:id])
        #
        expect(subject).to receive(:current_user) do
          double.tap do |a|
            expect(a).to receive(:characters) do
              double.tap do |b|
                expect(b).to receive(:find_by!).with(character_id: "1")
                  .and_return(character)
              end
            end
          end
        end
      end

      before { expect(character).to receive(:destroy!) }

      context "when format turbo stream" do
        before { delete :destroy, params: {id: "1", format: "turbo_stream"} }

        it { expect(subject).to respond_with(:ok) }

        it { expect(subject).to render_template(:destroy) }

        it { expect(subject).to set_flash.now[:notice].to("Character was successfully removed.") }
      end

      context "when format html" do
        before { delete :destroy, params: {id: "1", format: "html"} }

        it { expect(subject).to respond_with(:see_other) }

        it { expect(subject).to redirect_to(characters_path) }

        it { expect(subject).to set_flash[:notice].to("Character was successfully removed.") }
      end
    end

    context "when user not signed in" do
      before { delete :destroy, params: {id: "1"} }

      it { expect(subject).to redirect_to(new_user_session_path) }
    end
  end
end
