require 'rails_helper'

describe ApiKeyDecorator do
  describe '#as_json' do
    let(:api_key) do
      stub_model ApiKey,
                 id: 123,
                 key_id: 1234567,
                 v_code: '4a66f384d27c59af02f16746d480689ee3674b58a0d822518eb57bddd4e904f7'
    end

    subject { api_key.decorate.as_json }

    its([:id]) { should eq(123) }

    its([:key_id]) { should eq(1234567) }

    its([:v_code]) { should eq('4a66f384d27c59af02f16746d480689ee3674b58a0d822518eb57bddd4e904f7') }
  end
end
