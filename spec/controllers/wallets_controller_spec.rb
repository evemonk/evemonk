# frozen_string_literal: true

require "rails_helper"

describe WalletsController do
  it { should be_a(ApplicationController) }

  it { should use_before_action(:authenticate_user!) }

  describe "#update" do
    context "when user signed in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      before { expect(subject).to receive(:current_user_locale) }

      let(:character) { instance_double(Character, character_id: 1) }

      before do
        #
        # subject.current_user.characters
        #        .find_by!(character_id: params[:character_id]) # => character
        #
        expect(subject).to receive(:current_user) do
          double.tap do |a|
            expect(a).to receive(:characters) do
              double.tap do |b|
                expect(b).to receive(:find_by!).with(character_id: "1").and_return(character)
              end
            end
          end
        end
      end

      before do
        #
        # CharacterWalletJob.perform_later(character.character_id)
        #
        expect(CharacterWalletJob).to receive(:perform_later).with(1)
      end

      before { patch :update, params: {character_id: "1"} }

      it { should respond_with(:ok) }
    end

    context "when user not signed in" do
      before { patch :update, params: {character_id: "1"} }

      it { should redirect_to(new_user_session_path) }
    end
  end
end
