# frozen_string_literal: true

module Views
  module Universe
    module Types
      class Show < Phlex::HTML
        include Rails.application.routes.url_helpers

        def initialize(type:)
          @type = type
        end

        def template
          render Views::Shared::Breadcrumb.new do
            render Views::Shared::BreadcrumbItem.new(title: "Home", to: root_path)
            # render Views::Shared::BreadcrumbItem.new(title: "Types", to: universe_types_path)
            render Views::Shared::BreadcrumbItemActive.new(text: @type.name)
          end
        end
      end
    end
  end
end
