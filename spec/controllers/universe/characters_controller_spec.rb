# frozen_string_literal: true

require "rails_helper"

describe Universe::CharactersController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#index" do
    before do
      #
      # Eve::CharactersSearcher.new(params[:q])
      #                        .search
      #                        .page(params[:page])
      #                        .decorate
      #
      expect(Eve::CharactersSearcher).to receive(:new).with("character") do
        double.tap do |a|
          expect(a).to receive(:search) do
            double.tap do |b|
              expect(b).to receive(:page).with("2") do
                double.tap do |c|
                  expect(c).to receive(:decorate)
                end
              end
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
    let!(:eve_character) { create(:eve_character, character_id: 91_752_503) }

    before do
      #
      # Eve::Character
      #   .includes(:alliance, :corporation)
      #   .find_by!(character_id: params[:id])
      #   .decorate # => eve_character
      #
      expect(Eve::Character).to receive(:includes).with(:alliance, :corporation) do
        double.tap do |a|
          expect(a).to receive(:find_by!).with(character_id: "91752503") do
            double.tap do |b|
              expect(b).to receive(:decorate).and_return(eve_character)
            end
          end
        end
      end
    end

    before do
      #
      # Eve::CharacterCorporationHistory.where(character_id: @character.character_id)
      #                                 .includes(:corporation)
      #                                 .order(start_date: :desc)
      #                                 .decorate
      #
      expect(Eve::CharacterCorporationHistory).to receive(:where).with(character_id: eve_character.character_id) do
        double.tap do |a|
          expect(a).to receive(:includes).with(:corporation) do
            double.tap do |b|
              expect(b).to receive(:order).with(start_date: :desc) do
                double.tap do |c|
                  expect(c).to receive(:decorate)
                end
              end
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
