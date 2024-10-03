# frozen_string_literal: true

require "rails_helper"

RSpec.describe BlueprintsListsController do
  it { is_expected.to be_an(ApplicationController) }

  it { is_expected.to use_before_action(:authenticate_user!) }

  describe "#index" do
    context "when user signed in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      before { expect(subject).to receive(:current_user_locale) }

      let(:character) { instance_double(Character) }

      before do
        #
        # subject.current_user
        #        .characters
        #        .find_by!(character_id: params[:character_id]) # => character
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
        # CharacterBlueprintsFilterForm.new(params[:filter])
        #
        expect(CharacterBlueprintsFilterForm).to receive(:new).with("3")
      end

      before do
        #
        # CharacterBlueprints.new(@character, params).query
        #
        expect(CharacterBlueprints).to receive(:new).with(character, "3") do
          double.tap do |a|
            expect(a).to receive(:query)
          end
        end
      end

      before { get :index, params: {character_id: "1", filter: "3"} }

      it { is_expected.to respond_with(:ok) }

      it { is_expected.not_to render_with_layout }

      it { is_expected.to render_template(:index) }
    end

    context "when user not signed in" do
      before { get :index, params: {character_id: "1"} }

      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end
end
