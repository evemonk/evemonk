# frozen_string_literal: true

require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    # sessions: Field::HasMany,
    # characters: Field::HasMany,
    id: Field::Number,
    email: Field::String,
    notifications_count: Field::Number,
    sign_in_count: Field::Number,
    confirmed_at: Field::DateTime,
    # authy_id: Field::String,
    # last_sign_in_with_authy: Field::DateTime,
    # authy_enabled: Field::Boolean,
    locale: Field::String.with_options(searchable: false),
    admin: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :id,
    :email,
    :confirmed_at,
    :sign_in_count,
    :admin
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :email,
    :notifications_count,
    :sign_in_count,
    # :current_sign_in_at,
    # :last_sign_in_at,
    # :current_sign_in_ip,
    # :last_sign_in_ip,
    :confirmed_at,
    # :confirmation_sent_at,
    # :authy_id,
    # :last_sign_in_with_authy,
    # :authy_enabled,
    :locale,
    :admin,
    :created_at,
    :updated_at
  ].freeze

  FORM_ATTRIBUTES = [
    :email,
    :notifications_count,
    :locale,
    :admin,
  ].freeze

  COLLECTION_FILTERS = {}.freeze
end
