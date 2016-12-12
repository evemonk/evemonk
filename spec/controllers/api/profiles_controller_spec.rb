require 'rails_helper'

describe Api::ProfilesController do
  # private methods

  describe '#resource' do
    let(:current_user) { double }

    before { expect(subject).to receive(:current_user).and_return(current_user) }

    specify { expect(subject.send(:resource)).to eq(current_user) }
  end
end
