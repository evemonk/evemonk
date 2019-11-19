# frozen_string_literal: true

require "rails_helper"

describe Universe::CharactersController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:require_login) }

  describe "#index" do
    let(:eve_character_policy) { Eve::Character }

    before do
      #
      # subject.policy_scope(::Eve::Character) # => eve_character_policy
      #
      expect(subject).to receive(:policy_scope).with(::Eve::Character).and_return(eve_character_policy)
    end

    before do
      #
      # Eve::CharactersSearcher.new(params[:q], policy_scope(::Eve::Character))
      #                       .search
      #                       .page(params[:page])
      #                       .decorate
      #
      expect(Eve::CharactersSearcher).to receive(:new).with("character", eve_character_policy) do
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
    let(:eve_character_policy) { Eve::Character }

    before do
      #
      # subject.policy_scope(::Eve::Character) # => eve_character_policy
      #
      expect(subject).to receive(:policy_scope).with(::Eve::Character).and_return(eve_character_policy)
    end

    let(:eve_character) { instance_double(Eve::Character) }

    before do
      #
      # subject.policy_scope(::Eve::Character)
      #        .includes(character_corporation_histories: :corporation)
      #        .find_by!(character_id: params[:id])
      #        .decorate
      expect(eve_character_policy).to receive(:includes).with(character_corporation_histories: :corporation) do
        double.tap do |a|
          expect(a).to receive(:find_by!).with(character_id: "91752503") do
            double.tap do |b|
              expect(b).to receive(:decorate).and_return(eve_character)
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
