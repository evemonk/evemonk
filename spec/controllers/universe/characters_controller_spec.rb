# frozen_string_literal: true

require "rails_helper"

describe Universe::CharactersController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#index" do
    before do
      #
      # Eve::SearchCharactersQuery.new(params[:q])
      #                           .query
      #                           .page(params[:page])
      #
      expect(Eve::SearchCharactersQuery).to receive(:new).with("character") do
        double.tap do |a|
          expect(a).to receive(:query) do
            double.tap do |b|
              expect(b).to receive(:page).with("2")
            end
          end
        end
      end
    end

    before { get :index, params: {q: "character", page: "2"} }

    it { should respond_with(:ok) }

    it { should render_template(:index) }
  end

  describe "#show" do
    let!(:eve_character) { create(:eve_character, id: 91_752_503) }

    before do
      #
      # Eve::Character
      #   .includes(:alliance, :corporation)
      #   .find(params[:id]) # => eve_character
      #
      expect(Eve::Character).to receive(:includes).with(:alliance, :corporation) do
        double.tap do |a|
          expect(a).to receive(:find).with("91752503").and_return(eve_character)
        end
      end
    end

    before do
      #
      # Eve::CharacterCorporationHistory.where(character: @character)
      #                                 .includes(:corporation)
      #                                 .order(start_date: :desc)
      #
      expect(Eve::CharacterCorporationHistory).to receive(:where).with(character: eve_character) do
        double.tap do |a|
          expect(a).to receive(:includes).with(:corporation) do
            double.tap do |b|
              expect(b).to receive(:order).with(start_date: :desc)
            end
          end
        end
      end
    end

    before { get :show, params: {id: "91752503"} }

    it { should respond_with(:ok) }

    it { should render_template(:show) }
  end
end
