# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::UsersController, type: :controller do
  it { expect(subject).to be_an(Admin::ApplicationController) }
end
