# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationPolicy do
  let(:user) { create(:user) }

  let(:record) { create(:user) }

  subject { described_class.new(user, record) }

  it { expect(subject).to forbid_all_actions }

  describe ApplicationPolicy::Scope do
    let(:user) { create(:user) }

    let(:scope) { User }

    subject { described_class.new(user, scope) }

    specify { expect { subject.resolve }.to raise_error(NotImplementedError) }
  end
end
