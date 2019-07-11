# frozen_string_literal: true

json.total_count @history.total_count
json.total_pages @history.total_pages
json.current_page @history.current_page


  # if @corporations_history.any?
  #   json.corporations_history do
  #     json.array! @corporations_history do |history|
  #       if history.corporation
  #         json.id history.corporation.corporation_id
  #         json.name history.corporation.name
  #         json.start_date history.start_date.iso8601
  #       end
  #     end
  #   end
  #
  #   # json.array! @character.character_corporation_histories do |history|
  #   #   if history.corporation
  #   #     json.corporation do
  #   #       json.id history.corporation.id
  #   #       json.name history.corporation.name
  #   #       json.start_date history.start_date.iso8601
  #   #     end
  #   #   end
  #   #
  #   # 		  # id: 160187,
  #   # 		  # character_id: 1337512245,
  #   # 		  # corporation_id: 1000049,
  #   # 		  # is_deleted: nil,
  #   # 		  # record_id: 17822677,
  #   # 		  # start_date: Thu, 08 Sep 2011 20:47:00 UTC +00:00,
  #   # 		  # created_at: Sun, 30 Jun 2019 20:18:11 UTC +00:00,
  #   # 		  # updated_at: Sun, 30 Jun 2019 20:18:11 UTC +00:00>,
  #   # end
  # end
