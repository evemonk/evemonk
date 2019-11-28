# frozen_string_literal: true

require "rails_helper"

describe CharactersController do
  it { should be_a(ApplicationController) }

  it { should use_before_action(:require_login) }

  describe "#index" do
    let(:current_user) { instance_double(User) }

    before { sign_in(current_user) }

    before do
      #
      # current_user.characters
      #             .includes(:alliance, :corporation)
      #             .order(created_at: :asc)
      #             .page(params[:page])
      #             .decorate
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

    before { get :index, params: {page: "1"} }

    it { should respond_with(:ok) }

    it { should render_template(:index) }
  end

  describe "#show" do
    let(:current_user) { instance_double(User) }

    before { sign_in(current_user) }

    before do
      #
      # current_user.characters
      #             .includes(:race, :bloodline, :ancestry, :faction, :alliance, :corporation)
      #             .find_by!(character_id: params[:id])
      #             .decorate
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

    before { get :show, params: {id: "1"} }

    it { should respond_with(:ok) }

    it { should render_template(:show) }
  end

  describe "#destroy"
end
