module Whatson
  class PostsController < WhatsonController

    before_filter :find_all_whatson_posts, :except => [:archive]
    before_filter :find_whatson_post, :only => [:show, :comment, :update_nav]
    before_filter :find_tags

    respond_to :html, :js, :rss

    def index
      # Rss feeders are greedy. Let's give them every whatson post instead of paginating.
      (@whatson_posts = WhatsonPost.live.includes(:comments, :categories).all) if request.format.rss?
      respond_with (@whatson_posts) do |format|
        format.html
        format.rss
      end
    end

    def show
      @whatson_comment = WhatsonComment.new
      @canonical = url_for(:locale => ::Refinery::I18n.default_frontend_locale) if canonical?

      respond_with (@whatson_post) do |format|
        format.html { present(@whatson_post) }
        format.js { render :partial => 'post', :layout => false }
      end
    end

    def comment
      if (@whatson_comment = @whatson_post.comments.create(params[:whatson_comment])).valid?
        if WhatsonComment::Moderation.enabled? or @whatson_comment.ham?
          begin
            Whatson::CommentMailer.notification(@whatson_comment, request).deliver
          rescue
            logger.warn "There was an error delivering a whatson comment notification.\n#{$!}\n"
          end
        end

        if WhatsonComment::Moderation.enabled?
          flash[:notice] = t('thank_you_moderated', :scope => 'whatson.posts.comments')
          redirect_to whatson_post_url(params[:id])
        else
          flash[:notice] = t('thank_you', :scope => 'whatson.posts.comments')
          redirect_to whatson_post_url(params[:id],
                                   :anchor => "comment-#{@whatson_comment.to_param}")
        end
      else
        render :action => 'show'
      end
    end

    def archive
      if params[:month].present?
        date = "#{params[:month]}/#{params[:year]}"
        @archive_date = Time.parse(date)
        @date_title = @archive_date.strftime('%B %Y')
        @whatson_posts = WhatsonPost.live.by_archive(@archive_date).paginate({
                                                                               :page => params[:page],
                                                                               :per_page => RefinerySetting.find_or_set(:whatson_posts_per_page, 10)
                                                                             })
      else
        date = "01/#{params[:year]}"
        @archive_date = Time.parse(date)
        @date_title = @archive_date.strftime('%Y')
        @whatson_posts = WhatsonPost.live.by_year(@archive_date).paginate({
                                                                            :page => params[:page],
                                                                            :per_page => RefinerySetting.find_or_set(:whatson_posts_per_page, 10)
                                                                          })
      end
      respond_with (@whatson_posts)
    end

    def tagged
      @tag = ActsAsTaggableOn::Tag.find(params[:tag_id])
      @tag_name = @tag.name
      @whatson_posts = WhatsonPost.tagged_with(@tag_name).paginate({
                                                                     :page => params[:page],
                                                                     :per_page => RefinerySetting.find_or_set(:whatson_posts_per_page, 10)
                                                                   })
    end

    protected

    def find_whatson_post
      unless (@whatson_post = WhatsonPost.find(params[:id])).try(:live?)
        if refinery_user? and current_user.authorized_plugins.include?("refinerycms_whatson")
          @whatson_post = WhatsonPost.find(params[:id])
        else
          error_404
        end
      end
    end

    def find_all_whatson_posts
      @whatson_posts = WhatsonPost.live.includes(:comments, :categories).paginate({
                                                                                    :page => params[:page],
                                                                                    :per_page => RefinerySetting.find_or_set(:whatson_posts_per_page, 10)
                                                                                  })
    end

    def find_tags
      @tags = WhatsonPost.tag_counts_on(:tags)
    end

    def canonical?
      ::Refinery.i18n_enabled? && ::Refinery::I18n.default_frontend_locale != ::Refinery::I18n.current_frontend_locale
    end
  end
end
