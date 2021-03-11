# frozen_string_literal: true

# TODO: update
module Eve
  class LocalCategoriesImporter
    def import
      Eve::Category.pluck(:category_id).each do |category_id|
        Eve::UpdateCategoryJob.perform_later(category_id)
      end
    end
  end
end
