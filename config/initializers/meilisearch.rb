# frozen_string_literal: true

Meilisearch::Rails.configuration = {
  meilisearch_url: ENV.fetch("MEILISEARCH_URL", nil),
  meilisearch_api_key: ENV.fetch("MEILISEARCH_API_KEY", nil),
  pagination_backend: :kaminari,
  per_environment: true
}
