# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::CharactersController do
  it { should be_a(Api::BaseController) }

  it { should_not use_before_action(:authenticate) }

  describe "#index" do
    context "with supported content type" do
      before do
        #
        # Eve::CharactersSearcher.new(params[:q])
        #                        .search
        #                        .page(params[:page])
        #                        .decorate
        #
        expect(Eve::CharactersSearcher).to receive(:new).with("search string") do
          double.tap do |a|
            expect(a).to receive(:search) do
              double.tap do |b|
                expect(b).to receive(:page).with("1") do
                  double.tap do |c|
                    expect(c).to receive(:decorate)
                  end
                end
              end
            end
          end
        end
      end

      before { get :index, params: {format: :json, page: "1", q: "search string"} }

      it { should respond_with(:ok) }

      it { should render_template(:index) }
    end

    context "when not supported accept type" do
      before { get :index, params: {format: :html} }

      it { should respond_with(:not_acceptable) }
    end
  end

  describe "#show" do
    context "with supported content type" do
      let(:eve_character) { instance_double(Eve::Character) }

      before do
        #
        # Eve::Character
        #   .find_by!(character_id: params[:id])
        #   .decorate
        #
        expect(Eve::Character).to receive(:find_by!).with(character_id: "90729314") do
          double.tap do |a|
            expect(a).to receive(:decorate)
          end
        end
      end

      before { get :show, params: {id: "90729314", format: :json} }

      it { should respond_with(:ok) }

      it { should render_template(:show) }
    end

    context "when not supported accept type" do
      before { get :show, params: {id: "90729314", format: :html} }

      it { should respond_with(:not_acceptable) }
    end

    context "when character not found" do
      before do
        #
        # Eve::Character
        #   .find_by!(character_id: params[:id]) # => ActiveRecord::RecordNotFound
        #
        expect(Eve::Character).to receive(:find_by!).with(character_id: "90729314")
          .and_raise(ActiveRecord::RecordNotFound)
      end

      before { get :show, params: {id: "90729314", format: :json} }

      it { should respond_with(:not_found) }
    end
  end
end
