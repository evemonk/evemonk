# frozen_string_literal: true

describe Api::SignUpForm, type: :model do
  it { should be_a(ActiveModel::Model) }

  xit { should validate_presence_of(:email) } # TODO: update shoulda-matchers and enable this spec

  xit { should validate_presence_of(:password) } # TODO: update shoulda-matchers and enable this spec

  xit { should validate_presence_of(:password_confirmation) } # TODO: update shoulda-matchers and enable this spec

  it { should validate_confirmation_of(:password) }

  it { should delegate_method(:id).to(:session) }

  it { should delegate_method(:token).to(:session) }

  describe '#save' do
    context 'when user valid' do
      let(:params) do
        {
          email: 'me@example.com',
          password: 'password',
          password_confirmation: 'password'
        }
      end

      subject { described_class.new(params) }

      specify { expect(subject.save).to eq(true) }

      specify { expect { subject.save }.to change(User, :count).by(1) }

      specify { expect { subject.save }.to change(Session, :count).by(1) }

      pending { expect { subject.save }.to change { User.first&.authenticate('password') }.from(nil).to(User.first) }
    end

    context 'when user not valid' do
      let(:params) do
        {
          email: nil,
          password: nil,
          password_confirmation: nil
        }
      end

      subject { described_class.new(params) }

      specify { expect(subject.save).to eq(false) }

      specify { expect { subject.save }.not_to change(User, :count) }

      specify { expect { subject.save }.not_to change(Session, :count) }
    end

    context 'when user valid but email has already been taken' do
      let!(:existed_user) { create(:user, email: 'ME@EXAMPLE.COM') }

      let(:params) do
        {
          email: 'me@example.com',
          password: 'password',
          password_confirmation: 'password'
        }
      end

      subject { described_class.new(params) }

      specify { expect(subject.save).to eq(false) }

      specify { expect { subject.save }.to change { subject.errors[:email] }.from([]).to(['has already been taken']) }
    end
  end
end
