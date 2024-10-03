# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::GraphicDashboard do
  it { is_expected.to be_an(Administrate::BaseDashboard) }
end
