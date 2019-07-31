# frozen_string_literal: true

json.character do
  json.id @character.character_id
  json.icon @character.icon
  json.birthday @character.birthday
  json.description @character.description
  json.gender @character.gender
  json.name @character.name
  json.security_status @character.security_status
  json.title @character.title

  if @character.alliance
    json.partial! partial: "api/eve/shared/alliance",
                  locals: {alliance: @character.alliance}
  end

  if @character.ancestry
    json.partial! partial: "api/eve/shared/ancestry",
                  locals: {ancestry: @character.ancestry}
  end

  if @character.bloodline
    json.partial! partial: "api/eve/shared/bloodline",
                  locals: {bloodline: @character.bloodline}
  end

  if @character.corporation
    json.partial! partial: "api/eve/shared/corporation",
                  locals: {corporation: @character.corporation}
  end

  if @character.faction
    json.partial! partial: "api/eve/shared/faction",
                  locals: {faction: @character.faction}
  end

  if @character.race
    json.partial! partial: "api/eve/shared/race",
                  locals: {race: @character.race}
  end
end
