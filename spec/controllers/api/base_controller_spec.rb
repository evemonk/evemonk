# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::BaseController do
  it { is_expected.to be_a(ActionController::Base) }

  it { is_expected.to use_before_action(:verify_requested_format!) }

  it { is_expected.to rescue_from(ActiveRecord::RecordNotFound) }

  it { is_expected.to rescue_from(ActionController::UnknownFormat) }
end
