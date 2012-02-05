module Whatson
  class CategoriesController < WhatsonController

    def show
      @category = WhatsonCategory.find(params[:id])
      @whatson_posts = @category.posts.live.includes(:comments, :categories).paginate({
        :page => params[:page],
        :per_page => RefinerySetting.find_or_set(:whatson_posts_per_page, 10)
      })
    end

  end
end