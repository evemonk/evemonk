# frozen_string_literal: true

require "rails_helper"

describe BlueprintsController do
  it { should be_a(ApplicationController) }

  it { should use_before_action(:authenticate_user!) }

  describe "#index" do
    context "when user signed in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      let(:character) { instance_double(Character) }

      before do
        #
        # current_user.characters
        #             .includes(:alliance, :corporation)
        #             .find_by!(character_id: params[:character_id])
        #             .decorate
        #
        expect(subject).to receive(:current_user) do
          double.tap do |a|
            expect(a).to receive(:characters) do
              double.tap do |b|
                expect(b).to receive(:includes).with(:alliance, :corporation) do
                  double.tap do |c|
                    expect(c).to receive(:find_by!).with(character_id: "1") do
                      double.tap do |d|
                        expect(d).to receive(:decorate).and_return(character)
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end

      before do
        #
        # character.character_blueprints
        #          .includes(:blueprint)
        #          .page(params[:page])
        #          .per(10)
        #          .decorate
        #
        expect(character).to receive(:character_blueprints) do
          double.tap do |a|
            expect(a).to receive(:includes).with(:blueprint) do
              double.tap do |b|
                expect(b).to receive(:page).with("2") do
                  double.tap do |c|
                    expect(c).to receive(:per).with(10) do
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

      before { get :index, params: {character_id: "1", page: "2"} }

      it { should respond_with(:ok) }

      it { should render_template(:index) }
    end

    context "when user not signed in" do
      before { get :index, params: {character_id: "1"} }

      it { should redirect_to(new_user_session_path) }
    end
  end
end
