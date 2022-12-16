# frozen_string_literal: true

module Views
  module Shared
    class BreadcrumbItem < Phlex::HTML
      def initialize(title:, to:)
        @title = title
        @to = to
      end
      def template
        li(class: "breadcrumb-item") { helpers.link_to(@title, @to) }
      end
    end
  end
end
