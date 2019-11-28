# frozen_string_literal: true

require "rails_helper"

describe AssetsController do
  it { should be_a(ApplicationController) }

  it { should use_before_action(:require_login) }

  describe "#index" do
    let(:current_user) { instance_double(User) }

    before { sign_in(current_user) }

    let(:character) { instance_double(Character) }

    before do
      #
      # current_user.characters
      #             .includes(:race, :bloodline, :ancestry, :faction, :alliance, :corporation)
      #             .find_by!(character_id: params[:character_id])
      #             .decorate
      #
      expect(current_user).to receive(:characters) do
        double.tap do |a|
          expect(a).to receive(:includes).with(:race, :bloodline, :ancestry, :faction, :alliance, :corporation) do
            double.tap do |b|
              expect(b).to receive(:find_by!).with(character_id: "1") do
                double.tap do |c|
                  expect(c).to receive(:decorate).and_return(character)
                end
              end
            end
          end
        end
      end
    end

    before do
      #
      # character.character_assets
      #          .includes(:type)
      #
      expect(character).to receive(:character_assets) do
        double.tap do |a|
          expect(a).to receive(:includes).with(:type)
        end
      end
    end

    before { get :index, params: {character_id: "1"} }

    it { should respond_with(:ok) }

    it { should render_template(:index) }
  end
end
