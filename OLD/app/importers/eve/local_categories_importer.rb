# frozen_string_literal: true

module Eve
  class LocalCategoriesImporter
    def import
      Eve::Category.ids.each do |id|
        Eve::UpdateCategoryJob.perform_later(id)
      end
    end
  end
end
