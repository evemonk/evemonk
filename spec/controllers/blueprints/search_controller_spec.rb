# frozen_string_literal: true

require "rails_helper"

describe Blueprints::SearchController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#index" do
    before do
      #
      # Eve::SearchBlueprintsQuery.new(params[:q]).query.limit(10)
      #
      expect(Eve::SearchBlueprintsQuery).to receive(:new).with("Drake") do
        double.tap do |a|
          expect(a).to receive(:query) do
            double.tap do |b|
              expect(b).to receive(:limit).with(10)
            end
          end
        end
      end
    end

    before { get :index, params: {q: "Drake"} }

    it { should respond_with(:ok) }

    it { should render_template(:index) }
  end
end
