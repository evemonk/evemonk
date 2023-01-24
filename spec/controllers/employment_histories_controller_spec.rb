# frozen_string_literal: true

require "rails_helper"

describe EmploymentHistoriesController do
  it { should be_an(ApplicationController) }

  it { should use_before_action(:authenticate_user!) }

  describe "#index" do
    context "when user signed in" do
      let!(:user) { create(:user) }

      let!(:character) { create(:character, user: user, character_id: 123) }

      before { sign_in(user) }

      before { expect(subject).to receive(:current_user_locale) }

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
                    expect(c).to receive(:find_by!).with(character_id: "123").and_return(character)
                  end
                end
              end
            end
          end
        end
      end

      before do
        #
        # CharacterCorporationHistory.where(character_id: character.character_id)
        #                            .includes(:corporation)
        #                            .order(start_date: :desc)
        #
        expect(CharacterCorporationHistory).to receive(:where).with(character_id: character.character_id) do
          double.tap do |a|
            expect(a).to receive(:includes).with(:corporation) do
              double.tap do |b|
                expect(b).to receive(:order).with(start_date: :desc)
              end
            end
          end
        end
      end

      before { get :index, params: {character_id: "123"} }

      it { should respond_with(:ok) }

      it { should render_template(:index) }
    end

    context "when user not signed in" do
      before { get :index, params: {character_id: "123"} }

      it { should redirect_to(new_user_session_path) }
    end
  end
end
