# frozen_string_literal: true

require "rails_helper"

describe BlueprintsController do
  it { should be_an(ApplicationController) }

  it { should use_before_action(:authenticate_user!) }

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
        #        .find_by!(character_id: params[:character_id])
        #
        expect(subject).to receive(:current_user) do
          double.tap do |a|
            expect(a).to receive(:characters) do
              double.tap do |b|
                expect(b).to receive(:includes).with(:alliance, :corporation) do
                  double.tap do |c|
                    expect(c).to receive(:find_by!).with(character_id: "1")
                  end
                end
              end
            end
          end
        end
      end

      before { get :index, params: {character_id: "1"} }

      it { should respond_with(:ok) }

      it { should render_template(:index) }
    end

    context "when user not signed in" do
      before { get :index, params: {character_id: "1"} }

      it { should redirect_to(new_user_session_path) }
    end
  end

  describe "#show" do
    context "when user signed in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      before { expect(subject).to receive(:current_user_locale) }

      let(:character) { instance_double(Character) }

      before do
        #
        # subject.current_user
        #        .characters
        #        .includes(:alliance, :corporation)
        #        .find_by!(character_id: params[:character_id]) # => character
        #
        expect(subject).to receive(:current_user) do
          double.tap do |a|
            expect(a).to receive(:characters) do
              double.tap do |b|
                expect(b).to receive(:includes).with(:alliance, :corporation) do
                  double.tap do |c|
                    expect(c).to receive(:find_by!).with(character_id: "1")
                      .and_return(character)
                  end
                end
              end
            end
          end
        end
      end

      let(:character_blueprint) { instance_double(CharacterBlueprint) }

      before do
        #
        # character.character_blueprints
        #          .includes(:blueprint) # => character_blueprint
        #
        expect(character).to receive(:character_blueprints) do
          double.tap do |a|
            expect(a).to receive(:includes).with(:blueprint)
              .and_return(character_blueprint)
          end
        end
      end

      before do
        #
        # character.character_blueprints
        #          .includes(:blueprint)
        #          .find_by!(item_id: params[:id])
        #
        expect(character).to receive(:character_blueprints) do
          double.tap do |a|
            expect(a).to receive(:includes).with(:blueprint) do
              double.tap do |b|
                expect(b).to receive(:find_by!).with(item_id: "2")
              end
            end
          end
        end
      end

      before { get :show, params: {character_id: "1", id: "2"} }

      it { should respond_with(:ok) }

      it { should render_template(:show) }
    end

    context "when user not signed in" do
      before { get :show, params: {character_id: "1", id: "2"} }

      it { should redirect_to(new_user_session_path) }
    end
  end
end
