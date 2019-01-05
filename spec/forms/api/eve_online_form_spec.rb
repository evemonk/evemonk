# frozen_string_literal: true

require 'rails_helper'

describe Api::EveOnlineForm do
  describe '#initialize' do
    let(:request) { double }

    subject { described_class.new(request) }

    its(:request) { should eq(request) }
  end
end
