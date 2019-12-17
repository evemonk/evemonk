# frozen_string_literal: true

require "rails_helper"

describe ApplicationController do
  it { should use_before_action(:authenticate_user!) }
end
