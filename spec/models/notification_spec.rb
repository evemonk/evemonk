# frozen_string_literal: true

require "rails_helper"

describe Notification do
  it { should be_an(ApplicationRecord) }

  it { should be_a(Noticed::Model) }

  it { should belong_to(:recipient) }
end
