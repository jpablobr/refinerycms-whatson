module Admin
  module Whatson
    class SettingsController < Admin::BaseController

      def notification_recipients
        @recipients = WhatsonComment::Notification.recipients

        if request.post?
          WhatsonComment::Notification.recipients = params[:recipients]
          flash[:notice] = t('updated', :scope => 'admin.whatson.settings.notification_recipients',
                             :recipients => WhatsonComment::Notification.recipients)
          unless request.xhr? or from_dialog?
            redirect_back_or_default(admin_whatson_posts_path)
          else
            render :text => "<script type='text/javascript'>parent.window.location = '#{admin_whatson_posts_path}';</script>",
                   :layout => false
          end
        end
      end

      def moderation
        enabled = WhatsonComment::Moderation.toggle!
        unless request.xhr?
          redirect_back_or_default(admin_whatson_posts_path)
        else
          render :json => {:enabled => enabled},
                 :layout => false
        end
      end

      def comments
        enabled = WhatsonComment.toggle!
        unless request.xhr?
          redirect_back_or_default(admin_whatson_posts_path)
        else
          render :json => {:enabled => enabled},
                 :layout => false
        end
      end
      
      def teasers
        enabled = WhatsonPost.teaser_enabled_toggle!
        unless request.xhr?
          redirect_back_or_default(admin_whatson_posts_path)
        else
          render :json => {:enabled => enabled},
                 :layout => false
        end
      end

    end
  end
end