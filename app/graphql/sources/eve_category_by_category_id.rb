# frozen_string_literal: trues

class Sources::EveCategoryByCategoryId < GraphQL::Dataloader::Source
  # def initialize(model_class)
  #   @model_class = model_class
  # end

  def fetch(ids)
    # records = @model_class.where(id: ids)
    # # return a list with `nil` for any ID that wasn't found
    # ids.map { |id| records.find { |r| r.id == id.to_i } }

    records = ::Eve::Category.where(category_id: ids)
    # return a list with `nil` for any ID that wasn't found
    ids.map { |id| records.find { |r| r.category_id == id.to_i } }
  end
end
