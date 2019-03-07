# frozen_string_literal: true

require 'rails_helper'

describe Api::Eve::CorporationsController do
  it { should be_a(Api::BaseController) }

  it { should_not use_before_action(:authenticate) }
end
