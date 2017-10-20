# frozen_string_literal: true
require 'rails_helper'

describe Api::EveOnline do
  let(:request) { double }

  subject { described_class.new(request) }

  describe '#initialize' do
    its(:request) { should eq(request) }
  end

  # TODO: write more specs
end
