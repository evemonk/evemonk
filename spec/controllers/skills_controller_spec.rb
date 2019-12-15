# frozen_string_literal: true

require "rails_helper"

describe SkillsController do
  it { should be_a(ApplicationController) }

  it { should use_before_action(:require_login) }

  describe "#index" do
    let(:current_user) { instance_double(User) }

    before { sign_in(current_user) }

    let(:character) { instance_double(Character) }

    before do
      #
      # current_user.characters
      #             .includes(character_skills: :skill)
      #             .find_by!(character_id: params[:character_id])
      #             .decorate
      #
      expect(current_user).to receive(:characters) do
        double.tap do |a|
          expect(a).to receive(:includes).with(character_skills: :skill) do
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

    before { expect(current_user).to receive(:set_last_activity_at).with(any_args) }

    before { get :index, params: {character_id: "1"} }

    it { should respond_with(:ok) }

    it { should render_template(:index) }
  end
end
