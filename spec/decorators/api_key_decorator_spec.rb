require 'rails_helper'

describe ApiKeyDecorator do
  describe '#as_json' do
    let(:api_key) do
      stub_model ApiKey,
                 id: 123,
                 key_id: 1_234_567,
                 v_code: '4a66f384d27c59af02f16746d480689ee3674b58a0d822518eb57bddd4e904f7'
    end

    let(:created_at) { double }

    let(:updated_at) { double }

    let(:api_key_decorated) { api_key.decorate }

    before { expect(api_key_decorated).to receive(:created_at).and_return(created_at) }

    before { expect(api_key_decorated).to receive(:updated_at).and_return(updated_at) }

    subject { api_key_decorated.as_json }

    its([:id]) { should eq(123) }

    its([:key_id]) { should eq(1_234_567) }

    its([:v_code]) { should eq('4a66f384d27c59af02f16746d480689ee3674b58a0d822518eb57bddd4e904f7') }

    its([:created_at]) { should eq(created_at) }

    its([:updated_at]) { should eq(updated_at) }
  end

  # private methods

  describe '#created_at' do
    let(:api_key) { stub_model ApiKey }

    subject { api_key.decorate }

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
    let(:api_key) { stub_model ApiKey }

    subject { api_key.decorate }

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
