# frozen_string_literal: true

require "rails_helper"

describe BlueprintsListsController do
  it { should be_an(ApplicationController) }

  it { should use_before_action(:authenticate_user!) }

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

      it { should respond_with(:ok) }

      it { should_not render_with_layout }

      it { should render_template(:index) }
    end

    context "when user not signed in" do
      before { get :index, params: {character_id: "1"} }

      it { should redirect_to(new_user_session_path) }
    end
  end
end
