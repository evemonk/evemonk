# frozen_string_literal: true

require 'rails_helper'

describe Api::Eve::AllianceCorporationsController do
  it { should be_a(Api::BaseController) }

  it { should_not use_before_action(:authenticate) }

  describe '#index' do
  end
end
