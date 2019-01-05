# frozen_string_literal: true

require 'rails_helper'

describe Api::EveOnlineForm do
  let(:request) { double }

  subject { described_class.new(request) }

  describe '#initialize' do
    its(:request) { should eq(request) }
  end

  describe '#save!' do
    specify { expect { subject.save! }.not_to raise_error }
  end
end
