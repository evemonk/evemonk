# frozen_string_literal: true

require "rails_helper"

describe CharactersController do
  it { should be_a(ApplicationController) }

  it { should use_before_action(:require_login) }

  describe "#index" do
    let(:current_user) { instance_double(User) }

    before { sign_in(current_user) }

    before do
      #
      # current_user.characters
      #             .includes(:alliance, :corporation)
      #             .order(created_at: :asc)
      #             .page(params[:page])
      #             .decorate
      expect(current_user).to receive(:characters) do
        double.tap do |a|
          expect(a).to receive(:includes).with(:alliance, :corporation) do
            double.tap do |b|
              expect(b).to receive(:order).with(created_at: :asc) do
                double.tap do |c|
                  expect(c).to receive(:page).with("1") do
                    double.tap do |d|
                      expect(d).to receive(:decorate)
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

    it { should respond_with(:ok) }

    it { should render_template(:index) }
  end

  describe "#show" do
    let(:current_user) { instance_double(User) }

    before { sign_in(current_user) }

    before do
      #
      # current_user.characters
      #             .includes(:race, :bloodline, :ancestry, :faction, :alliance, :corporation)
      #             .find_by!(character_id: params[:id])
      #             .decorate
      #
      expect(current_user).to receive(:characters) do
        double.tap do |a|
          expect(a).to receive(:includes).with(:race, :bloodline, :ancestry, :faction, :alliance, :corporation) do
            double.tap do |b|
              expect(b).to receive(:find_by!).with(character_id: "1") do
                double.tap do |c|
                  expect(c).to receive(:decorate)
                end
              end
            end
          end
        end
      end
    end

    before { get :show, params: {id: "1"} }

    it { should respond_with(:ok) }

    it { should render_template(:show) }
  end

  describe "#update" do
    let(:current_user) { instance_double(User) }

    before { sign_in(current_user) }

    let(:character) { build(:character, character_id: 1) }

    before do
      #
      # current_user.characters.find_by!(character_id: params[:id])
      #
      expect(current_user).to receive(:characters) do
        double.tap do |a|
          expect(a).to receive(:find_by!).with(character_id: "1")
            .and_return(character)
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

    context "when format js" do
      before { patch :update, params: {id: "1", format: "js"} }

      it { should respond_with(:ok) }

      it { should render_template(:update) }
    end

    context "when format html" do
      before { patch :update, params: {id: "1", format: "html"} }

      it { should redirect_to(character_path(character.character_id)) }
    end
  end

  describe "#destroy" do
    let(:current_user) { instance_double(User) }

    before { sign_in(current_user) }

    let(:character) { instance_double(Character) }

    before do
      #
      # current_user.characters.find_by!(character_id: params[:id])
      #
      expect(current_user).to receive(:characters) do
        double.tap do |a|
          expect(a).to receive(:find_by!).with(character_id: "1")
            .and_return(character)
        end
      end
    end

    before { expect(character).to receive(:destroy!) }

    before { delete :destroy, params: {id: "1", format: "js"} }

    it { should respond_with(:ok) }

    it { should render_template(:destroy) }
  end
end
