# frozen_string_literal: true

require 'rails_helper'

describe Api::Eve::CharacterCorporationsHistoryController do
  it { should be_a(Api::BaseController) }

  it { should_not use_before_action(:authenticate) }

  describe '#index' do
    context 'with supported content type' do
    end

    context 'when not supported accept type' do
      before { get :index, params: { character_id: '99005443', format: :html } }

      it { should respond_with(:not_acceptable) }
    end

    context 'when character not found' do
      before do
        #
        # subject.policy_scope(::Eve::Character)
        #        .find_by!(character_id: params[:character_id]) # => ActiveRecord::RecordNotFound
        #
        expect(subject).to receive(:policy_scope).with(Eve::Character) do
          double.tap do |a|
            expect(a).to receive(:find_by!).with(character_id: '99005443')
                                           .and_raise(ActiveRecord::RecordNotFound)
          end
        end
      end

      before { get :index, params: { character_id: '99005443', format: :json } }

      it { should respond_with(:not_found) }
    end
  end
end
