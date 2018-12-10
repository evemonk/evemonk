# frozen_string_literal: true

json.id @user.id
json.email @user.email
json.characters_count @user.characters.count
json.created_at @user.created_at.iso8601
json.updated_at @user.updated_at.iso8601
