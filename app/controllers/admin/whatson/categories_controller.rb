module Admin
  module Whatson
    class CategoriesController < Admin::BaseController

      crudify :whatson_category,
              :title_attribute => :title,
              :order => 'title ASC'

    end
  end
end
