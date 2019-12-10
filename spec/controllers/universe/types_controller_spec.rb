# frozen_string_literal: true

require "rails_helper"

describe Universe::TypesController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:require_login) }

  describe "#index" # TODO: write

  describe "#show" do
    before do
      #
      # Eve::Type.find_by!(type_id: params[:id]).decorate
      #
      expect(Eve::Type).to receive(:find_by!).with(type_id: "9899") do
        double.tap do |a|
          expect(a).to receive(:decorate)
        end
      end
    end

    before { get :index, params: {id: "9899"} }

    it { should respond_with(:ok) }

    it { should render_template(:show) }
  end
end
