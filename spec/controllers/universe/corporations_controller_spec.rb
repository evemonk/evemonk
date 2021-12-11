# frozen_string_literal: true

require "rails_helper"

describe Universe::CorporationsController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#index" do
    let(:collection) { double }

    before do
      #
      # Eve::SearchCorporationsQuery.new(params[:q])
      #                             .query # => collection
      #
      expect(Eve::SearchCorporationsQuery).to receive(:new).with("corporation") do
        double.tap do |a|
          expect(a).to receive(:query).and_return(collection)
        end
      end
    end

    before { expect(subject).to receive(:pagy).with(collection) }

    before { get :index, params: {q: "corporation"} }

    it { should respond_with(:ok) }

    it { should render_template(:index) }
  end

  describe "#show" do
    let(:eve_corporation) { instance_double(Eve::Corporation) }

    before do
      #
      # Eve::Corporation
      #   .find_by!(corporation_id: params[:id])
      #
      expect(Eve::Corporation).to receive(:find_by!).with(corporation_id: "1000001").and_return(eve_corporation)
    end

    before do
      #
      # Eve::Character
      #   .where(corporation: @corporation)
      #   .order(:name)
      #
      expect(Eve::Character).to receive(:where).with(corporation: eve_corporation) do
        double.tap do |a|
          expect(a).to receive(:order).with(:name)
        end
      end
    end

    before { get :show, params: {id: "1000001"} }

    it { should respond_with(:ok) }

    it { should render_template(:show) }
  end
end
