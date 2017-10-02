{
  collection: collection.decorate.as_json,
  total_pages: collection.total_pages,
  current_page: collection.current_page,
  total_entries: collection.total_count
}.to_json
