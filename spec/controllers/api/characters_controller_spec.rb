# frozen_string_literal: true

require "rails_helper"

describe Api::CharactersController do
  it { should be_a(Api::BaseController) }

  describe "#index" do
    context "when user signed in" do
      before { sign_in }

      before do
        #
        # subject.policy_scope(Character).includes(:alliance, :corporation)
        #                                .order(created_at: :asc)
        #                                .page(params[:page])
        #                                .decorate
        #
        expect(subject).to receive(:policy_scope).with(Character) do
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

      before { subject.instance_variable_set(:@_pundit_policy_scoped, true) }

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
      let(:character) { instance_double(Character, character_id: 1) }

      before { sign_in }

      before do
        #
        # Character.eager_load(:race,
        #                      :bloodline,
        #                      :ancestry,
        #                      :faction,
        #                      :alliance,
        #                      :corporation)
        #          .find_by!(character_id: params[:id])
        #          .decorate
        #
        expect(Character).to receive(:eager_load).with(:race,
                                                       :bloodline,
                                                       :ancestry,
                                                       :faction,
                                                       :alliance,
                                                       :corporation) do
          double.tap do |a|
            expect(a).to receive(:find_by!).with(character_id: "1") do
              double.tap do |b|
                expect(b).to receive(:decorate).and_return(character)
              end
            end
          end
        end
      end

      before { expect(subject).to receive(:authorize).with(character) }

      before { subject.instance_variable_set(:@_pundit_policy_authorized, true) }

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
      let(:character) { instance_double(Character, character_id: 1) }

      before { sign_in }

      before { expect(Character).to receive(:find_by!).with(character_id: "1").and_return(character) }

      before { expect(subject).to receive(:authorize).with(character) }

      before { expect(character).to receive(:destroy!) }

      before { subject.instance_variable_set(:@_pundit_policy_authorized, true) }

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
