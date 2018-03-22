# frozen_string_literal: true

every 1.day do
  rake 'eve:races eve:bloodlines eve:factions eve:ancestries'
end

every 1.week do
  rake 'eve:alliances'
end
