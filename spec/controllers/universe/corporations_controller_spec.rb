# frozen_string_literal: true

require "rails_helper"

describe Universe::CorporationsController do
  it { should be_a(ApplicationController) }

  describe "#index" do
    let(:eve_corporation_policy) { Eve::Corporation }

    before do
      #
      # subject.policy_scope(::Eve::Corporation) # => eve_corporation_policy
      #
      expect(subject).to receive(:policy_scope).with(::Eve::Corporation).and_return(eve_corporation_policy)
    end

    before do
      #
      # Eve::CorporationsSearcher.new(params[:q], policy_scope(::Eve::Corporation))
      #                          .search
      #                          .page(params[:page])
      #                          .decorate
      #
      expect(Eve::CorporationsSearcher).to receive(:new).with("corporation", eve_corporation_policy) do
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

    before { subject.instance_variable_set(:@_pundit_policy_scoped, true) }

    before { get :index, params: {q: "corporation", page: "2"} }

    it { should respond_with(:ok) }

    it { should render_template(:index) }
  end

  describe "#show" do
    let(:eve_corporation) { instance_double(Eve::Corporation) }

    before do
      #
      # subject.policy_scope(::Eve::Corporation)
      #        .find_by!(corporation_id: params[:id])
      #        .decorate
      #
      expect(subject).to receive(:policy_scope).with(Eve::Corporation) do
        double.tap do |a|
          expect(a).to receive(:find_by!).with(corporation_id: "1000001") do
            double.tap do |b|
              expect(b).to receive(:decorate).and_return(eve_corporation)
            end
          end
        end
      end
    end

    before do
      #
      # subject.policy_scope(::Eve::Character)
      #        .where(corporation: @corporation)
      #        .order(:name)
      #        .decorate
      #
      expect(subject).to receive(:policy_scope).with(Eve::Character) do
        double.tap do |a|
          expect(a).to receive(:where).with(corporation: eve_corporation) do
            double.tap do |b|
              expect(b).to receive(:order).with(:name) do
                double.tap do |c|
                  expect(c).to receive(:decorate)
                end
              end
            end
          end
        end
      end
    end

    before { get :show, params: {id: "1000001"} }

    it { should respond_with(:ok) }

    it { should render_template(:show) }
  end
end
