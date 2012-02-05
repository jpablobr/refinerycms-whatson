class WhatsonController < ApplicationController

  helper :whatson_posts
  before_filter :find_page, :find_all_whatson_categories

protected

  def find_page
    @page = Page.find_by_link_url("/whatson")
  end

  def find_all_whatson_categories
    @whatson_categories = WhatsonCategory.all
  end

end
