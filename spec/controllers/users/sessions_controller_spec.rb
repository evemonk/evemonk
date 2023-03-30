# frozen_string_literal: true

require "rails_helper"

describe Users::SessionsController do
  it { should be_a(Devise::SessionsController) }
end
