require 'rails_helper'

describe Api::CharactersController do
  # private methods

  describe '#resource' do
    context 'found' do
      let!(:user) { create(:user) }

      let!(:character) { create(:character, user: user, id: 123) }

      before { expect(subject).to receive(:current_user).and_return(user) }

      let(:params) { { id: '123' } }

      before { expect(subject).to receive(:params).and_return(params) }

      specify { expect(subject.send(:resource)).to eq(character) }

      specify { expect { subject.send(:resource) }.to change { subject.instance_variable_get(:@character) }.from(nil).to(character) }
    end

    context 'not found' do
      let!(:user) { create(:user) }

      let!(:character) { create(:character, id: 123) }

      before { expect(subject).to receive(:current_user).and_return(user) }

      let(:params) { { id: '123' } }

      before { expect(subject).to receive(:params).and_return(params) }

      specify { expect { subject.send(:resource) }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'memoization' do
      let(:character) { double }

      before { subject.instance_variable_set(:@character, character) }

      specify { expect(subject.send(:resource)).to eq(character) }
    end
  end

  describe '#collection' do
    let!(:user) { create(:user) }

    let!(:character1) { create(:character, user: user) }

    let!(:character2) { create(:character, user: user) }

    before { expect(subject).to receive(:current_user).and_return(user) }

    specify { expect(subject.send(:collection)).to eq([character1, character2]) }

    specify { expect { subject.send(:collection) }.to change { subject.instance_variable_get(:@characters) }.from(nil) }
  end
end
