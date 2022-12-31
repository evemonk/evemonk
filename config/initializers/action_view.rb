# frozen_string_literal: true

# https://coderwall.com/p/s-zwrg/remove-rails-field_with_errors-wrapper
ActionView::Base.field_error_proc = proc do |html_tag, _|
  html_tag.html_safe # rubocop:disable Rails/OutputSafety
end
