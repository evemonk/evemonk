# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::CharacterCorporationsHistoryController do
  it { should be_a(Api::BaseController) }

  it { should_not use_before_action(:authenticate) }

  describe "#index" do
    context "with supported content type" do
      before do
        #
        # Eve::CharacterCorporationHistory
        #   .includes(:corporation)
        #   .where(character: character)
        #   .order(record_id: :desc)
        #   .page(params[:page])
        #   .decorate
        #
        expect(Eve::CharacterCorporationHistory).to receive(:includes).with(:corporation) do
          double.tap do |a|
            expect(a).to receive(:where).with(character_id: "99005443") do
              double.tap do |b|
                expect(b).to receive(:order).with(record_id: :desc) do
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

      before { get :index, params: {character_id: "99005443", page: "1", format: :json} }

      it { should respond_with(:ok) }

      it { should render_template(:index) }
    end

    context "when not supported accept type" do
      before { get :index, params: {character_id: "99005443", format: :html} }

      it { should respond_with(:not_acceptable) }
    end
  end
end
