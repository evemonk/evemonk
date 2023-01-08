# frozen_string_literal: true

require "rails_helper"

describe AgentsController do
  it { should be_an(ApplicationController) }

  it { should use_before_action(:authenticate_user!) }

  describe "#index" do
    context "when user signed in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      before { expect(subject).to receive(:current_user_locale) }

      before do
        #
        # subject.current_user.characters
        #        .includes(:alliance, :corporation, agents_standings: {standingable: :division})
        #        .find_by!(character_id: params[:character_id])
        #
        expect(subject).to receive(:current_user) do
          double.tap do |a|
            expect(a).to receive(:characters) do
              double.tap do |b|
                expect(b).to receive(:includes).with(:alliance, :corporation, agents_standings: {standingable: :division}) do
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
end
