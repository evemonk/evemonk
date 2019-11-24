# frozen_string_literal: true

json.email current_user.email
json.characters_count current_user.characters.count
json.created_at current_user.created_at.iso8601
json.updated_at current_user.updated_at.iso8601
