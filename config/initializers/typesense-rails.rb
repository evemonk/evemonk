# frozen_string_literal: true

Typesense.configuration = {
  nodes: [
    {
      host: ENV.fetch("TYPESEARCH_HOST", "localhost"),
      port: ENV.fetch("TYPESEARCH_PORT", "8108"),
      protocol: ENV.fetch("TYPESEARCH_PROTOCOL", "http")
    }
  ],
  api_key: ENV.fetch("TYPESEARCH_API_KEY", "API_KEY"),
  connection_timeout_seconds: 2,
  log_level: :info, # Messages below this level will be silenced. One of (:debug, :info, :warn, :error, :fatal),
  pagination_backend: :kaminari
}
