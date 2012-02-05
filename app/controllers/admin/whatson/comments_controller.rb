module Admin
  module Whatson
    class CommentsController < Admin::BaseController

      crudify :whatson_comment,
              :title_attribute => :name,
              :order => 'published_at DESC'

      def index
        @whatson_comments = WhatsonComment.unmoderated
        render :action => 'index'
      end

      def approved
        unless params[:id].present?
          @whatson_comments = WhatsonComment.approved
          render :action => 'index'
        else
          @whatson_comment = WhatsonComment.find(params[:id])
          @whatson_comment.approve!
          flash[:notice] = t('approved', :scope => 'admin.whatson.comments', :author => @whatson_comment.name)
          redirect_to :action => params[:return_to] || 'index'
        end
      end

      def rejected
        unless params[:id].present?
          @whatson_comments = WhatsonComment.rejected
          render :action => 'index'
        else
          @whatson_comment = WhatsonComment.find(params[:id])
          @whatson_comment.reject!
          flash[:notice] = t('rejected', :scope => 'admin.whatson.comments', :author => @whatson_comment.name)
          redirect_to :action => params[:return_to] || 'index'
        end
      end

    end
  end
end