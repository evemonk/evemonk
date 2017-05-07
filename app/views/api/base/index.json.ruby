{
  collection: ActiveDecorator::Decorator.instance.decorate(collection).as_json,
  total_pages: collection.total_pages,
  current_page: collection.current_page
}.to_json
