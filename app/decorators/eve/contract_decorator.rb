# frozen_string_literal: true

module Eve
  class ContractDecorator < ApplicationDecorator
    decorates_associations :region, :issuer, :issuer_corporation
  end
end
