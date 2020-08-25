# frozen_string_literal: true

require "rails_helper"

describe Admin::Eve::MarketGroupsController do
  it_behaves_like "disable modification", Eve::MarketGroup

  it { should be_an(Admin::ApplicationController) }

  it { should be_an(Admin::DisableModifications) }
end
