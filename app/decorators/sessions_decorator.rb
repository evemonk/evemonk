# frozen_string_literal: true

class SessionsDecorator < Draper::CollectionDecorator
  def as_json(*)
    {
      collection: object,
      total_pages: object.total_pages,
      current_page: object.current_page,
      total_entries: object.total_count
    }
  end
end
