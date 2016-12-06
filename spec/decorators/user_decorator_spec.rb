require 'rails_helper'

describe UserDecorator do
  describe '#as_json' do
    let(:created_at) { double }

    let(:updated_at) { double }

    let(:user) do
      stub_model User,
                 id: 42,
                 email: 'me@example.com'
    end

    let(:decorated_object) { user.decorate }

    before { expect(decorated_object).to receive(:created_at).and_return(created_at) }

    before { expect(decorated_object).to receive(:updated_at).and_return(updated_at) }

    subject { decorated_object.as_json }

    its([:id]) { should eq(42) }

    its([:email]) { should eq('me@example.com') }

    its([:created_at]) { should eq(created_at) }

    its([:updated_at]) { should eq(updated_at) }
  end

  # private methods

  describe '#created_at' do
    let(:user) { stub_model User }

    subject { user.decorate }

    before do
      #
      # subject.model.created_at.iso8601
      #
      expect(subject).to receive(:model) do
        double.tap do |a|
          expect(a).to receive(:created_at) do
            double.tap do |b|
              expect(b).to receive(:iso8601)
            end
          end
        end
      end
    end

    specify { expect { subject.send(:created_at) }.not_to raise_error }
  end

  describe '#updated_at' do
    let(:user) { stub_model User }

    subject { user.decorate }

    before do
      #
      # subject.model.updated_at.iso8601
      #
      expect(subject).to receive(:model) do
        double.tap do |a|
          expect(a).to receive(:updated_at) do
            double.tap do |b|
              expect(b).to receive(:iso8601)
            end
          end
        end
      end
    end

    specify { expect { subject.send(:updated_at) }.not_to raise_error }
  end
end
