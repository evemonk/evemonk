# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::GraphicDashboard do
  it { expect(subject).to be_an(Administrate::BaseDashboard) }
end
