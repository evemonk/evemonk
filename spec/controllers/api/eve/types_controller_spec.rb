# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::TypesController do
  it { should be_a(Api::BaseController) }

  describe "#index" do
    context "with supported content type" do
      before do
        #
        # Eve::Type
        #   .where(published: true)
        #   .includes(:type_dogma_attributes, :type_dogma_effects)
        #   .decorate
        #
        expect(Eve::Type).to receive(:where).with(published: true) do
          double.tap do |a|
            expect(a).to receive(:includes).with(:type_dogma_attributes, :type_dogma_effects) do
              double.tap do |b|
                expect(b).to receive(:decorate)
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
      before do
        #
        # Eve::Type
        #   .where(published: true)
        #   .includes(:type_dogma_attributes, :type_dogma_effects)
        #   .find_by!(type_id: params[:id])
        #   .decorate
        #
        expect(Eve::Type).to receive(:where).with(published: true) do
          double.tap do |a|
            expect(a).to receive(:includes).with(:type_dogma_attributes, :type_dogma_effects) do
              double.tap do |b|
                expect(b).to receive(:find_by!).with(type_id: "23773") do
                  double.tap do |c|
                    expect(c).to receive(:decorate)
                  end
                end
              end
            end
          end
        end
      end

      before { get :show, params: {id: "23773", format: :json} }

      it { should respond_with(:ok) }

      it { should render_template(:show) }
    end

    context "when not supported accept type" do
      before { get :show, params: {id: "23773", format: :html} }

      it { should respond_with(:not_acceptable) }
    end
  end
end
