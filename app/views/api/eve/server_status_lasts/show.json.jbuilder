# frozen_string_literal: true

json.server_status do
  json.players @server_status.players
  json.server_version @server_status.server_version
  json.start_time @server_status.start_time&.iso8601
  json.vip @server_status.vip
end
