# frozen_string_literal: true

require "rails_helper"

describe Api::CharactersController do
  it { should be_a(Api::BaseController) }

  describe "#index" do
    context "when user signed in" do
      let(:current_user) { instance_double(User) }

      before { api_sign_in(current_user) }

      before do
        #
        # current_user.characters
        #   .includes(:alliance, :corporation)
        #   .order(created_at: :asc)
        #   .page(params[:page])
        #   .decorate
        #
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

      before { get :index, params: {format: :json, page: "1"} }

      it { should respond_with(:ok) }

      it { should render_template(:index) }
    end

    context "when user not signed in" do
      before { get :index, params: {format: :json} }

      it { should respond_with(:unauthorized) }
    end

    context "when not supported accept type" do
      before { get :index, params: {format: :html} }

      it { should respond_with(:not_acceptable) }
    end
  end

  describe "#show" do
    context "when user signed in" do
      let(:current_user) { instance_double(User) }

      before { api_sign_in(current_user) }

      before do
        #
        # current_user.characters
        #   .includes(:race, :bloodline, :ancestry, :faction, :alliance, :corporation)
        #   .find_by!(character_id: params[:id])
        #   .decorate
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

      before { get :show, params: {id: "1", format: :json} }

      it { should respond_with(:ok) }

      it { should render_template(:show) }
    end

    context "when user not signed in" do
      before { get :show, params: {id: "1", format: :json} }

      it { should respond_with(:unauthorized) }
    end

    context "when not supported accept type" do
      before { get :show, params: {id: "1", format: :html} }

      it { should respond_with(:not_acceptable) }
    end
  end

  describe "#destroy" do
    context "when user signed in" do
      let(:current_user) { instance_double(User) }

      before { api_sign_in(current_user) }

      before do
        #
        # current_user.characters.find_by!(character_id: params[:id]).destroy!
        #
        expect(current_user).to receive(:characters) do
          double.tap do |a|
            expect(a).to receive(:find_by!).with(character_id: "1") do
              double.tap do |b|
                expect(b).to receive(:destroy!)
              end
            end
          end
        end
      end

      before { delete :destroy, params: {id: "1", format: :json} }

      it { should respond_with(:no_content) }
    end

    context "when user not signed in" do
      before { delete :destroy, params: {id: "1", format: :json} }

      it { should respond_with(:unauthorized) }
    end

    context "when not supported accept type" do
      before { delete :destroy, params: {id: "1", format: :html} }

      it { should respond_with(:not_acceptable) }
    end
  end
end
