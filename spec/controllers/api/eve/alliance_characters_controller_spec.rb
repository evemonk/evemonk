# frozen_string_literal: true

require 'rails_helper'

describe Api::Eve::AllianceCharactersController do
  it { should be_a(Api::BaseController) }

  it { should_not use_before_action(:authenticate) }

  describe '#index' do
    context 'with supported content type' do
      let(:alliance) { instance_double(Eve::Alliance) }

      before { expect(Eve::Alliance).to receive(:find_by!).with(alliance_id: '12345').and_return(alliance) }

      before do
        #
        # Eve::Character.where(alliance: alliance)
        #               .includes(:alliance,
        #                         :ancestry,
        #                         :bloodline,
        #                         :corporation,
        #                         :faction,
        #                         :race)
        #               .page(params[:page])
        #
        expect(Eve::Character).to receive(:where).with(alliance: alliance) do
          double.tap do |a|
            expect(a).to receive(:includes).with(:alliance,
                                                 :ancestry,
                                                 :bloodline,
                                                 :corporation,
                                                 :faction,
                                                 :race) do
              double.tap do |b|
                expect(b).to receive(:page).with('1')
              end
            end
          end
        end
      end

      before { subject.instance_variable_set(:@_pundit_policy_scoped, true) }

      before { get :index, params: { format: :json, page: '1', alliance_id: '12345' } }

      it { should respond_with(:ok) }

      it { should render_template(:index) }
    end

    context 'when not supported accept type' do
      before { get :index, params: { alliance_id: '12345', format: :html } }

      it { should respond_with(:not_acceptable) }
    end
  end
end
