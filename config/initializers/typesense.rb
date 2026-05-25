# frozen_string_literal: true

TYPESENSE_CLIENT = Typesense::Client.new(
  nodes: [
    {
      host: ENV.fetch("TYPESEARCH_HOST"),
      port: ENV.fetch("TYPESEARCH_PORT"),
      protocol: ENV.fetch("TYPESEARCH_PROTOCOL")
    }
  ],
  api_key: ENV.fetch("TYPESEARCH_API_KEY"),
  connection_timeout_seconds: 2
)
