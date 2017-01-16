require 'rails_helper'

describe Api::SignOut do
  let(:request) { double }

  subject { described_class.new(request) }

  it { should be_a(ActionController::HttpAuthentication::Token) }

  describe '#initialize' do
    specify { expect(subject.request).to eq(request) }
  end

  describe '#destroy!' do
    let!(:session) { create(:session) }

    let(:options) { double }

    before do
      #
      # subject.token_and_options(request) => [token, options]
      #
      expect(subject).to receive(:token_and_options).with(request)
                                                    .and_return([session.token, options])
    end

    specify { expect { subject.destroy! }.to change { Session.count }.from(1).to(0) }
  end
end
