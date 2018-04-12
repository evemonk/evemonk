# frozen_string_literal: true

class PaginatingDecorator < Draper::CollectionDecorator
  delegate :current_page, :total_pages, :limit_value, :entry_name,
           :total_count, :offset_value, :last_page?

  def as_json(*)
    {
      collection: object.map(&:decorate).map(&:as_json),
      total_pages: object.total_pages,
      current_page: object.current_page,
      total_entries: object.total_count
    }
  end
end
